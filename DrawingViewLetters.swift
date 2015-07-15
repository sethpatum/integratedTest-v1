//
//  DrawingViewLetters.swift
//  Integrated test v1
//
//  Created by School on 7/15/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import Foundation


import UIKit

var letters = Letters()

class DrawingViewLetters: UIView {
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
    
    override func drawRect(rect: CGRect) {
        //println("in drawRect")
        for letter in letters.letterlist{
            drawLetters(letter)
        }
        
        UIColor.blackColor().set()
        opaque = false
        backgroundColor = nil
        path.stroke()
        
    }
    
    func reset() {
        println("In reset")
        path.removeAllPoints()
        
        letters.randomize()
        
        setNeedsDisplay()
    }
    
    func drawLetters(letter:(Int, Int, String)){
        
        
        let (x, y, name) = letter
        //println("Bubble \(bubble)")
        
        var context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 3.0);
        
        // Set the circle outerline-colour
        UIColor.redColor().set()
        
        
        // Draw
        CGContextStrokePath(context);
        
        // Now for the text
        
        // Flip the context coordinates, in iOS only.
        //CGContextTranslateCTM(context, 0, self.bounds.size.height);
        //CGContextScaleCTM(context, 1.0, -1.0);
        
        let f: CGFloat = CGFloat(fontLetters)
        
        let aFont = UIFont(name: "Optima-Bold", size: f)
        
        // create a dictionary of attributes to be applied to the string
        let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.redColor()]
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
        var touch = touches.first as! UITouch
        path.moveToPoint(touch.locationInView(self))
        setNeedsDisplay()
        
        letters.inNewLetter(touch.locationInView(self).x, y:touch.locationInView(self).y)
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        //println("Touch moved")
        var touch = touches.first as! UITouch
        path.addLineToPoint(touch.locationInView(self))
        setNeedsDisplay()
        
        letters.inNewLetter(touch.locationInView(self).x, y:touch.locationInView(self).y)
        
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
    
}