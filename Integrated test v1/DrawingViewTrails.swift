//
//  DrawingViewTrails.swift
//  Integrated test v1
//
//  Created by School on 7/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import Foundation

import UIKit


class DrawingViewTrails: UIView {
    
    
    private var currPath = UIBezierPath()
   
    var errorPath = UIBezierPath()
    
    var mainPath = UIBezierPath()
    
    var bubbles = BubblesA()
    
    var nextBubb = 0
    
    var incorrect = 0
    
    
//ADDITION
    var paths = [UIBezierPath]()
    
    
    var countSinceCorrect = 0
    var canDraw = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        print("Initializing")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.whiteColor()
        currPath.lineWidth = 5
        currPath.lineCapStyle = CGLineCap.Round
        
        mainPath.lineWidth = 5
        mainPath.lineCapStyle = CGLineCap.Round
        
        errorPath.lineWidth = 3
        errorPath.lineCapStyle = CGLineCap.Round
        
    }
    
    
    func drawResultBackground() {
        
        for bubble in bubbles.bubblelist {
            drawBubble(bubble)
        }
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        
//ADDITION
        print("should have drawn colored bezierpath")
        print("paths has \(paths.count) members; timedConnectionsA length is \(timedConnectionsA.count)")
        
        if (timedConnectionsA.count > 0){
            
            for var k = 2; k < timedConnectionsA.count; ++k {
                let z = timedConnectionsA[k-1] - timedConnectionsA[k-2]
                
                getColor2(z, alpha: 0.8).set()
                
                let path : UIBezierPath = paths[k-1]
                
                path.lineWidth = 7
                path.lineCapStyle = CGLineCap.Round
                
                path.stroke()
                
            }
            
        }
        
        UIColor.blueColor().set()
        errorPath.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        //println("in drawRect")
        
        
        for bubble in bubbles.bubblelist {
            drawBubble(bubble)
        }
        
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        currPath.stroke()
        mainPath.stroke()
        
    }
    
    func reset() {
        print("In reset")
        
        mainPath.removeAllPoints()
        currPath.removeAllPoints()
        errorPath.removeAllPoints()
        
        setNeedsDisplay()
    }
    
    func drawBubble(bubble:(Int, Int, String)) {
        //println("in drawbubble")
        
        
        let (x, y, name) = bubble
        //println("Bubble \(bubble)")
        
        let context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 3.0);
        
        // Set the circle outerline-colour
        bubbleColor!.set()
        
        
        // Create Circle
        CGContextAddArc(context, CGFloat(x), CGFloat(y), 20, 0.0, CGFloat(M_PI * 2.0), 1)
        
        // Draw
        CGContextStrokePath(context);
        
        // Now for the text
        
        // Flip the context coordinates, in iOS only.
        //CGContextTranslateCTM(context, 0, self.bounds.size.height);
        //CGContextScaleCTM(context, 1.0, -1.0);
        
        let aFont = UIFont(name: "Menlo-Bold", size: 24)
        // create a dictionary of attributes to be applied to the string
        let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
        // create the attributed string
        let text = CFAttributedStringCreate(nil, name, attr)
        // create the line of text
        let line = CTLineCreateWithAttributedString(text)
        
        CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
        
        let num = name.characters.count
        
        if num == 1 {
            CGContextSetTextPosition(context, CGFloat(x-7), CGFloat(y+8))
        }
        
        else {
            CGContextSetTextPosition(context, CGFloat(x-14), CGFloat(y+8))
        }
        
        CTLineDraw(line, context!)
        
        if (name == "1") {
            let aFont = UIFont(name: "Menlo", size: 19)
            let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
            let text = CFAttributedStringCreate(nil, "START", attr)
            let line = CTLineCreateWithAttributedString(text)
            CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
            CGContextSetTextPosition(context, CGFloat(x-28), CGFloat(y+41))
            CTLineDraw(line, context!)
        }
        
        if ((selectedTest == "Trails A" && name == "25") ||
            (selectedTest == "Trails A Practice" && name == "6") ||
             (selectedTest == "Trails B" && name == "13") ||
            (selectedTest == "Trails B Practice" && name == "C")) {
            let aFont = UIFont(name: "Menlo", size: 19)
            let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
            let text = CFAttributedStringCreate(nil, "END", attr)
            let line = CTLineCreateWithAttributedString(text)
            CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
            CGContextSetTextPosition(context, CGFloat(x-16), CGFloat(y+41))
            CTLineDraw(line, context!)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //println("Touch Begin")
        
        if nextBubb != bubbles.bubblelist.count {
            canDraw = true
        }
        
        let touch = touches.first! as UITouch
        currPath.moveToPoint(touch.locationInView(self))
        
        setNeedsDisplay()
        
        //var currentPath = UIBezierPath()
        
        if bubbles.inNewBubble(touch.locationInView(self).x, y:touch.locationInView(self).y) == true {
            
            if bubbles.inCorrectBubble() == true {
                
                mainPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                
//ADDITION
                
                if bubbles.currentBubble == nextBubb {
                    var p = UIBezierPath()
                    p = UIBezierPath(CGPath: currPath.CGPath)
                    paths.append(p)
                    
                    
                    print("paths added member; length is \(paths.count); currBubb = \(bubbles.currentBubble); nextBubb = \(bubbles.nextBubble)")
                    
                    
                    nextBubb += 1
                    
                }
                else {
                    var p = UIBezierPath()
                    p = UIBezierPath(CGPath: currPath.CGPath)
                    errorPath.appendPath(p)
                }
                
                currPath.removeAllPoints()
                currPath.moveToPoint(touch.locationInView(self))
                
//                countSinceCorrect = 0
                
                print("in correct bubble")
                
            }
                
            else {
                
//                countSinceCorrect += 1
//                print("countSinceCorrect = \(countSinceCorrect)")
                
//                if countSinceCorrect > 1 || (countSinceCorrect == 1 && (selectedTest == "Trails A Practice" || selectedTest == "Trails B Practice")) {
                    
                    errorPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                    
//                    print("countSinceCorrect = \(countSinceCorrect); removing all pts and resetting")
                    
                    currPath.removeAllPoints()
                    
//                    countSinceCorrect = 0
                    
                    canDraw = false
                    
                    print("should have removed all pts")
                    
                    incorrect += 1
                    
//                }
                
            }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //println("Touch moved")
        let touch = touches.first! as UITouch
        
        if canDraw == true {
            currPath.addLineToPoint(touch.locationInView(self))
            
            setNeedsDisplay()
            
            if bubbles.inNewBubble(touch.locationInView(self).x, y:touch.locationInView(self).y) == true {
                
                print("in a new bubble")
                
                if bubbles.inCorrectBubble() == true {
                    
                    mainPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                    
//ADDITION
                    
                    if bubbles.currentBubble == nextBubb {
                        var p = UIBezierPath()
                        p = UIBezierPath(CGPath: currPath.CGPath)
                        paths.append(p)
                        
                        
                        print("paths added member; length is \(paths.count); currBubb = \(bubbles.currentBubble); nextBubb = \(bubbles.nextBubble)")
                        
                        
                        nextBubb += 1
                        
                    }
                    else {
                        var p = UIBezierPath()
                        p = UIBezierPath(CGPath: currPath.CGPath)
                        
                        errorPath.appendPath(p)
                        
                    }
                    
                    currPath.removeAllPoints()
                    currPath.moveToPoint(touch.locationInView(self))
                    
//                    countSinceCorrect = 0
                    
                    print("in correct bubble")
                    
                }
                    
                else {
                    
//                    countSinceCorrect += 1
                    print("countSinceCorrect = \(countSinceCorrect); currBubb = \(bubbles.currentBubble); nextBubb = \(bubbles.nextBubble)")
                    
//                    if countSinceCorrect > 1 || (countSinceCorrect == 1 && (selectedTest == "Trails A Practice" || selectedTest == "Trails B Practice")) {
                        
                        errorPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                        
//                        print("countSinceCorrect = \(countSinceCorrect); removing all pts and resetting")
                        
                        currPath.removeAllPoints()
                        
//                        countSinceCorrect = 0
                        
                        canDraw = false
                        
                        print("should have removed all pts")
                        
                        incorrect += 1
                        
//                    }
                    
                }
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //println("Touch Ended")
        
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