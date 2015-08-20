//
//  DrawingViewCircles.swift
//  Integrated test v1
//
//  Created by School on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import Foundation

import UIKit


var circles = Circles()

class DrawingViewCircles: UIView {
    private var path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        println("Initializing")
    }
    
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.whiteColor()
        path.lineWidth = 5
        path.lineCapStyle = kCGLineCapRound
    }
    
    
    func drawResultBackground() {
        for circle in circles.circlelist{
            drawCircles(circle)
        }
        
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        path.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        //println("in drawRect")
        for circle in circles.circlelist{
            drawCircles(circle)
        }
        
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        path.stroke()
    }
    
    func reset() {
        println("In reset")
        
        path.removeAllPoints()
        
        circles.randomizeList()
        
        println("randomized list")
        
        setNeedsDisplay()
    }
    
    func drawCircles(circle:(Int, Int, Int)){
        
        //println("in drawCircle")
        let (x, y, z) = circle
        //println("Bubble \(bubble)")
        
        var context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 3.0);
        
        // Set the circle outerline-colour
        UIColor.redColor().set()
        
        // Create Circle
        
        if(z==0){
            CGContextAddArc(context, CGFloat(x), CGFloat(y), 20, 0.0, CGFloat(M_PI * 2.0), 1)
        }
        if(z==1){
            CGContextAddArc(context, CGFloat(x), CGFloat(y), 20, CGFloat(M_PI/6.0), CGFloat(11.0*M_PI/6.0), 0)
        }
        if(z==2){
            CGContextAddArc(context, CGFloat(x), CGFloat(y), 20, CGFloat(5*M_PI/6.0), CGFloat(7.0*M_PI/6.0), 1)
        }
        
        // Draw
        CGContextStrokePath(context);
        
        /*
        // Now for the text
        
        // Flip the context coordinates, in iOS only.
        //CGContextTranslateCTM(context, 0, self.bounds.size.height);
        //CGContextScaleCTM(context, 1.0, -1.0);
        
        let aFont = UIFont(name: "Optima-Bold", size: 18)
        // create a dictionary of attributes to be applied to the string
        let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.redColor()]
        // create the attributed string
        let text = CFAttributedStringCreate(nil, name, attr)
        // create the line of text
        let line = CTLineCreateWithAttributedString(text)
        
        CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
        
        CGContextSetTextPosition(context, CGFloat(x-8), CGFloat(y+5))
        
        CTLineDraw(line, context)
        */
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //println("Touch Begin")
        var touch = touches.first as! UITouch
        path.moveToPoint(touch.locationInView(self))
        setNeedsDisplay()
        
        circles.inNewCircle(touch.locationInView(self).x, y:touch.locationInView(self).y)
        
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        //println("Touch moved")
        var touch = touches.first as! UITouch
        path.addLineToPoint(touch.locationInView(self))
        setNeedsDisplay()
        
        circles.inNewCircle(touch.locationInView(self).x, y:touch.locationInView(self).y)
        
    }
    
    
    /*
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    //println("Touch moved")
    var touch = touches.anyObject() as UITouch
    path.addLineToPoint(touch.locationInView(self))
    setNeedsDisplay()
    
    bubbles.inNewBubble(touch.locationInView(self).x, y:touch.locationInView(self).y)
    
    }
    */
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        //println("Touch Ended")
        var touch = touches.first as! UITouch
        
    }
    
    func getColor2(i: Double, alpha: Double = 1.0) -> UIColor {
        if (i < 5.0) {
            let h = CGFloat(0.3 - i / 15.0)
            return UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: CGFloat(alpha))
        } else if (i < 60) {
            let b = CGFloat((60.0 - i)/55.0)
            return UIColor(hue: 0.0, saturation: 1.0, brightness: b, alpha: CGFloat(alpha))
        } else {
            return UIColor(hue: 0.0, saturation: 1.0, brightness: 0.0, alpha: CGFloat(alpha))
        }
    }
    
}