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
    
    
    //Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = true
    var yt:Bool = true
    func transform(coord:(Int, Int)) -> (Int, Int) {
        var x = coord.0
        var y = coord.1
        if xt  {
            x  = 1000 - x
        }
        if yt {
            y = 600 - y
        }
        return (x, y)
    }
    
    init() {
        var coordList = [(Int, Int)]()
        
        let trailsAnames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"]
        let trailsBnames = ["1", "A", "2", "B", "3", "C", "4", "D", "5",  "E",  "6",  "F",  "7",  "G",  "8",  "H",  "9",  "I", "10",  "J", "11",  "K", "12",  "L", "13"]
        var names = [String]()
         if(selectedTest == "Trails A") {
            names = trailsAnames
         } else if(selectedTest == "Trails A") {
            names = trailsBnames
        } else if(selectedTest == "Trails A Practice") {
            names.append(trailsAnames[0])
            names.append(trailsAnames[1])
            names.append(trailsAnames[2])
            names.append(trailsAnames[3])
        } else {
            names.append(trailsBnames[0])
            names.append(trailsBnames[1])
            names.append(trailsBnames[2])
            names.append(trailsBnames[3])
            
        }
        
        // select from two possible coordinate systems
        let lst = arc4random_uniform(2000)
        if(lst < 1000) {
            coordList.append((720, 240))
            coordList.append((800, 270))
            coordList.append((820, 140))
            coordList.append((300, 120))
            coordList.append((375, 370))
            coordList.append((550, 190))
            coordList.append((385, 480))
            coordList.append((700, 470))
            coordList.append((775, 430))
            coordList.append((710, 370))
            coordList.append((950, 290))
            coordList.append((970, 555))
            coordList.append((500, 570))
            coordList.append((580, 515))
            coordList.append((110, 530))
            coordList.append((290, 510))
            coordList.append((70, 440))
            coordList.append((280, 315))
            coordList.append((190, 170))
            coordList.append((170, 290))
            coordList.append((40, 235))
            coordList.append((75, 40))
            coordList.append((925, 30))
            coordList.append((560, 80))
            coordList.append((970, 95))
        } else {
            coordList.append((490, 325))
            coordList.append((750, 175))
            coordList.append((810, 420))
            coordList.append((210, 365))
            coordList.append((360, 350))
            coordList.append((600, 200))
            coordList.append((200, 300))
            coordList.append((175, 110))
            coordList.append((490, 120))
            coordList.append((900, 100))
            coordList.append((860, 345))
            coordList.append((940, 500))
            coordList.append((475, 425))
            coordList.append((700, 485))
            coordList.append((150, 520))
            coordList.append((480, 535))
            coordList.append((160, 435))
            coordList.append((160, 210))
            coordList.append((110, 50))
            coordList.append((730, 75))
            coordList.append((950, 40))
            coordList.append((970, 570))
            coordList.append((620, 545))
            coordList.append((865, 550))
            coordList.append((90, 570))
        }
        
        xt = arc4random_uniform(2000) < 1000
        yt = arc4random_uniform(2000) < 1000
        coordList.map(transform)
       
        // off will move the starting point around
        let clen = coordList.count
        let sz:Int = min(clen, names.count)
        let off = Int(arc4random_uniform(UInt32(clen)))
        for i in 0...sz-1 {
            let j = (i + off)%clen
            let coord = coordList[j]
            bubblelist.append((coord.0, coord.1, names[i]))
            
        }
        
        println("lst=\(lst), xt=\(xt), yt=\(yt), off=\(off)")
        
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
