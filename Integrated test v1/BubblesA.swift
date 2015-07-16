//
//  BubblesA.swift
//  Integrated test v1
//
//  Created by School on 7/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import Foundation
import UIKit


class BubblesA {
    var bubblelist = [(Int,Int, String)]()
    let radius = 20
    
    var currentBubble = -1
    var lastBubble = -1
    
    var nextBubble = 0
    
    
    init() {
        bubblelist.append((720, 340, "1"))
        bubblelist.append((800, 370, "2"))
        bubblelist.append((820, 190, "3"))
        bubblelist.append((300, 170, "4"))
        bubblelist.append((375, 470, "5"))
        bubblelist.append((550, 290, "6"))
        bubblelist.append((400, 600, "7"))
        bubblelist.append((800, 590, "8"))
        bubblelist.append((875, 550, "9"))
        bubblelist.append((810, 490, "10"))
        bubblelist.append((950, 390, "11"))
        bubblelist.append((975, 670, "12"))
        bubblelist.append((510, 610, "13"))
        bubblelist.append((590, 665, "14"))
        bubblelist.append((100, 665, "15"))
        bubblelist.append((310, 610, "16"))
        bubblelist.append((60, 500, "17"))
        bubblelist.append((280, 415, "18"))
        bubblelist.append((190, 270, "19"))
        bubblelist.append((170, 390, "20"))
        bubblelist.append((40, 335, "21"))
        bubblelist.append((75, 90, "22"))
        bubblelist.append((925, 80, "23"))
        bubblelist.append((500, 125, "24"))
        bubblelist.append((970, 145, "25"))
        
    }
    
    func inBubble(x:CGFloat, y:CGFloat)->Int{
        
        for (index,bubble) in enumerate(bubblelist){
            let (a, b, name) = bubble
            
            var z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
            if z <= 700.0 {
                //println("inside bubble " + name)
                return index
            }
            
        }
        
        return -1
    }
    
    func inNewBubble(x:CGFloat, y:CGFloat) -> Bool {
        let curr = inBubble(x, y:y)
        if curr == currentBubble {
            return false
        }
        if curr == -1 {
            return false
        }
        println("Found new bubble \(curr)")
        
        
        lastBubble = currentBubble
        currentBubble = curr
        
        return true
        
    }
    
    func inCorrectBubble()->Bool{
        
        if currentBubble==nextBubble {
            
            nextBubble += 1
            
            if nextBubble == bubblelist.count {
                println("Done")
                nextBubble = 0
                stopTrailsA = true
                screenShotMethod()
            }
            
            return true
            
        }
        
        if currentBubble == nextBubble-1 {
            
            return true
            
        }
        
        currentBubble = lastBubble
        
        return false
        
    }
    
    
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
    
    
}
