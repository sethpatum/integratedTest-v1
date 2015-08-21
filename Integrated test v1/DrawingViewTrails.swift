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
    
    
//ADDITION
    var paths = [UIBezierPath]()
    
    
    var countSinceCorrect = 0
    var canDraw = true
    
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
        currPath.lineWidth = 5
        currPath.lineCapStyle = kCGLineCapRound
        
        mainPath.lineWidth = 5
        mainPath.lineCapStyle = kCGLineCapRound
        
        errorPath.lineWidth = 3
        errorPath.lineCapStyle = kCGLineCapRound
        
    }
    
    
    func drawResultBackground() {
        
        for bubble in bubbles.bubblelist {
            drawBubble(bubble)
        }
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        
//ADDITION
        println("should have drawn colored bezierpath")
        println("paths has \(paths.count) members; timedConnectionsA length is \(timedConnectionsA.count)")
        
        if (timedConnectionsA.count > 0){
            
            for var k = 2; k < timedConnectionsA.count; ++k {
                
                let (a, b, fillerA) = bubbles.bubblelist[k-2]
                let (x, y, fillerB) = bubbles.bubblelist[k-1]
                
                let z = timedConnectionsA[k-1] - timedConnectionsA[k-2]
                
                getColor2(z, alpha: 0.8).set()
                
                var path : UIBezierPath = paths[k-1]
                
                path.lineWidth = 7
                path.lineCapStyle = kCGLineCapRound
                
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
        println("In reset")
        
        mainPath.removeAllPoints()
        currPath.removeAllPoints()
        errorPath.removeAllPoints()
        
        setNeedsDisplay()
    }
    
    func drawBubble(bubble:(Int, Int, String)) {
        //println("in drawbubble")
        
        
        let (x, y, name) = bubble
        //println("Bubble \(bubble)")
        
        var context = UIGraphicsGetCurrentContext();
        
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
        
        let aFont = UIFont(name: "Optima-Bold", size: 18)
        // create a dictionary of attributes to be applied to the string
        let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
        // create the attributed string
        let text = CFAttributedStringCreate(nil, name, attr)
        // create the line of text
        let line = CTLineCreateWithAttributedString(text)
        
        CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
        
        CGContextSetTextPosition(context, CGFloat(x-8), CGFloat(y+5))
        
        CTLineDraw(line, context)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //println("Touch Begin")
        
        canDraw = true
        
        var touch = touches.first as! UITouch
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
                    
                    
                    println("paths added member; length is \(paths.count); currBubb = \(bubbles.currentBubble); nextBubb = \(bubbles.nextBubble)")
                    
                    
                    nextBubb += 1
                    
                }
                else {
                    var p = UIBezierPath()
                    p = UIBezierPath(CGPath: currPath.CGPath)
                    errorPath.appendPath(p)
                }
                
                currPath.removeAllPoints()
                currPath.moveToPoint(touch.locationInView(self))
                
                countSinceCorrect = 0
                
                println("in correct bubble")
                
            }
                
            else {
                
                countSinceCorrect += 1
                println("countSinceCorrect = \(countSinceCorrect)")
                
                if countSinceCorrect > 1 {
                    
                    errorPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                    
                    println("countSinceCorrect = \(countSinceCorrect); removing all pts and resetting")
                    
                    currPath.removeAllPoints()
                    
                    countSinceCorrect = 0
                    
                    canDraw = false
                    
                    println("should have removed all pts")
                }
                
            }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        //println("Touch moved")
        var touch = touches.first as! UITouch
        
        if canDraw == true {
            currPath.addLineToPoint(touch.locationInView(self))
            
            setNeedsDisplay()
            
            if bubbles.inNewBubble(touch.locationInView(self).x, y:touch.locationInView(self).y) == true {
                
                println("in a new bubble")
                
                if bubbles.inCorrectBubble() == true {
                    
                    mainPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                    
//ADDITION
                    
                    if bubbles.currentBubble == nextBubb {
                        var p = UIBezierPath()
                        p = UIBezierPath(CGPath: currPath.CGPath)
                        paths.append(p)
                        
                        
                        println("paths added member; length is \(paths.count); currBubb = \(bubbles.currentBubble); nextBubb = \(bubbles.nextBubble)")
                        
                        
                        nextBubb += 1
                        
                    }
                    else {
                        var p = UIBezierPath()
                        p = UIBezierPath(CGPath: currPath.CGPath)
                        
                        errorPath.appendPath(p)
                        
                    }
                    
                    currPath.removeAllPoints()
                    currPath.moveToPoint(touch.locationInView(self))
                    
                    countSinceCorrect = 0
                    
                    println("in correct bubble")
                    
                }
                    
                else {
                    
                    countSinceCorrect += 1
                    println("countSinceCorrect = \(countSinceCorrect); currBubb = \(bubbles.currentBubble); nextBubb = \(bubbles.nextBubble)")
                    
                    if countSinceCorrect > 1 {
                        
                        errorPath.appendPath(UIBezierPath(CGPath: currPath.CGPath))
                        
                        println("countSinceCorrect = \(countSinceCorrect); removing all pts and resetting")
                        
                        currPath.removeAllPoints()
                        
                        countSinceCorrect = 0
                        
                        canDraw = false
                        
                        println("should have removed all pts")
                    }
                    
                }
            }
        }
        
    }
    
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