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
        bubblelist.append((720, 240, "1"))
        bubblelist.append((800, 270, "2"))
        bubblelist.append((820, 140, "3"))
        bubblelist.append((300, 120, "4"))
        bubblelist.append((375, 370, "5"))
        bubblelist.append((550, 190, "6"))
        bubblelist.append((385, 480, "7"))
        bubblelist.append((700, 470, "8"))
        bubblelist.append((775, 430, "9"))
        bubblelist.append((710, 370, "10"))
        bubblelist.append((950, 290, "11"))
        bubblelist.append((970, 555, "12"))
        bubblelist.append((500, 570, "13"))
        bubblelist.append((580, 515, "14"))
        bubblelist.append((110, 530, "15"))
        bubblelist.append((290, 510, "16"))
        bubblelist.append((70, 440, "17"))
        bubblelist.append((280, 315, "18"))
        bubblelist.append((190, 170, "19"))
        bubblelist.append((170, 290, "20"))
        bubblelist.append((40, 235, "21"))
        bubblelist.append((75, 40, "22"))
        bubblelist.append((925, 30, "23"))
        bubblelist.append((560, 80, "24"))
        bubblelist.append((970, 95, "25"))
        
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
                
                timedConnectionsA.append(timePassedTrailsA)
                
                println("Done")
                nextBubble = 0
                stopTrailsA = true
                displayImgTrailsA = true
                screenShotMethod()
            }
            
            timedConnectionsA.append(timePassedTrailsA)
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
