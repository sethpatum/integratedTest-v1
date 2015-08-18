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
        if(selectedTest == "Trails A") {
            print("In Trails A")
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
        } else {
            print("In Trails B")
            // Trails B
            let random = Int(arc4random_uniform(3))
            println(random)
            let random1 = Int(arc4random_uniform(3))
            println(random1)
            let random5 = Int(arc4random_uniform(3))
            println(random5)
            let random2 = Int(arc4random_uniform(3))
            println(random2)
            let random3 = Int(arc4random_uniform(3))
            println(random3)
            let random4 = Int(arc4random_uniform(3))
            println(random4)
            let random6 = Int(arc4random_uniform(3))
            println(random6)
            
            if(random==0){
                
                bubblelist.append((720, 240, "1"))
                bubblelist.append((800, 270, "A"))
                bubblelist.append((820, 140, "2"))
                bubblelist.append((300, 120, "B"))
                bubblelist.append((375, 370, "3"))
                bubblelist.append((550, 190, "C"))
                bubblelist.append((385, 480, "4"))
                bubblelist.append((700, 470, "D"))
                bubblelist.append((775, 430, "5"))
                bubblelist.append((710, 370, "E"))
                bubblelist.append((950, 290, "6"))
                bubblelist.append((970, 555, "F"))
                bubblelist.append((500, 570, "7"))
                bubblelist.append((580, 515, "G"))
                bubblelist.append((110, 530, "8"))
                bubblelist.append((290, 510, "H"))
                bubblelist.append((70, 440, "9"))
                bubblelist.append((280, 315, "I"))
                bubblelist.append((190, 170, "10"))
                bubblelist.append((170, 290, "J"))
                bubblelist.append((40, 235, "11"))
                bubblelist.append((75, 40, "K"))
                bubblelist.append((925, 30, "12"))
                bubblelist.append((560, 80, "L"))
                bubblelist.append((970, 95, "13"))
                
            } else {
                bubblelist.append((490, 325, "1"))
                bubblelist.append((750, 175, "A"))
                bubblelist.append((810, 420, "2"))
                bubblelist.append((210, 365, "B"))
                bubblelist.append((360, 350, "3"))
                bubblelist.append((600, 200, "C"))
                bubblelist.append((200, 300, "4"))
                bubblelist.append((175, 110, "D"))
                bubblelist.append((490, 120, "5"))
                bubblelist.append((900, 100, "E"))
                bubblelist.append((860, 345, "6"))
                bubblelist.append((940, 500, "F"))
                bubblelist.append((475, 425, "7"))
                bubblelist.append((700, 485, "G"))
                bubblelist.append((150, 520, "8"))
                bubblelist.append((480, 535, "H"))
                bubblelist.append((160, 435, "9"))
                bubblelist.append((160, 210, "I"))
                bubblelist.append((110, 50, "10"))
                bubblelist.append((730, 75, "J"))
                bubblelist.append((950, 40, "11"))
                bubblelist.append((970, 570, "K"))
                bubblelist.append((620, 545, "12"))
                bubblelist.append((865, 550, "L"))
                bubblelist.append((90, 570, "13"))
                
            }
            
            
        }
        
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
        
//        currentBubble = lastBubble
        
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
