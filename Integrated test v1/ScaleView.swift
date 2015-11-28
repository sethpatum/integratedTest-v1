//
//  ScaleView.swift
//  Integrated test v1
//
//  Created by saman on 8/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

class ScaleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.whiteColor()
    }
    
    
    func reset() {
        setNeedsDisplay()
    }
    
    
    func lineseg(xStart:CGFloat, xEnd:CGFloat, cStart:CGFloat, cEnd:CGFloat) {
        var prev = CGPoint(x:xStart, y:10)
        
        let context = UIGraphicsGetCurrentContext();
        let aFont = UIFont(name: "Optima-Bold", size: 10)
        let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
        
        
        for i in 0...100 {
            let path = UIBezierPath()
            path.lineWidth = 5
            path.lineCapStyle = CGLineCap.Round
            
            let v = CGFloat(i)*(xEnd-xStart)/100.0 + xStart
            let next = CGPoint(x:v, y:10.0)
            path.moveToPoint(prev)
            path.addLineToPoint(next)
            
            let c = CGFloat(i)*(cEnd-cStart)/100.0 + cStart
            let cgc = getColor(Double(c))
            let uic = UIColor(CGColor:cgc)
            uic.set()
            path.stroke()
            prev = next
            
            if i % 10 == 0 {
                let text = CFAttributedStringCreate(nil, String(Int(c)), attr)
                let line = CTLineCreateWithAttributedString(text)
                CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
                CGContextSetTextPosition(context, CGFloat(v), CGFloat(25))
                CTLineDraw(line, context!)
            }
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        let mid = bounds.width / 2 - 20
        let end = bounds.width - 80.0
        lineseg(80.0, xEnd:mid, cStart:0.0, cEnd:10.0)
        lineseg(mid, xEnd:end, cStart:10.0, cEnd:60.0)
        
    }
    
    
    func getColor(i: Double) -> CGColor {
        if (i < 5.0) {
            let h = CGFloat(0.3 - i / 15.0)
            return UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: 1.0).CGColor
        } else if (i < 60) {
            let b = CGFloat((60.0 - i)/55.0)
            return UIColor(hue: 0.0, saturation: 1.0, brightness: b, alpha: 1.0).CGColor
        } else {
            return UIColor(hue: 0.0, saturation: 1.0, brightness: 0.0, alpha: 1.0).CGColor
        }
    }
    
    
}
