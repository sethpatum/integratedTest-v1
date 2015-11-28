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
            x  = 1010 - x
        }
        if yt {
            y = 625 - y
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
         } else if(selectedTest == "Trails B") {
            names = trailsBnames
        } else if(selectedTest == "Trails A Practice") {
            names.append(trailsAnames[0])
            names.append(trailsAnames[1])
            names.append(trailsAnames[2])
            names.append(trailsAnames[3])
            names.append(trailsAnames[4])
            names.append(trailsAnames[5])
        } else {
            names.append(trailsBnames[0])
            names.append(trailsBnames[1])
            names.append(trailsBnames[2])
            names.append(trailsBnames[3])
            names.append(trailsBnames[4])
            names.append(trailsBnames[5])
            
        }
        
        // select from two possible coordinate systems
        let lst = arc4random_uniform(2000)
        if(lst < 1000) {
            coordList.append((810, 280)) //720, 240
            coordList.append((710, 245)) //800, 270
            coordList.append((820, 150))
            coordList.append((300, 130))
            coordList.append((375, 380))
            coordList.append((550, 200))
            coordList.append((385, 490))
            coordList.append((700, 480))
            coordList.append((775, 440))
            coordList.append((710, 380))
            coordList.append((950, 300))
            coordList.append((970, 565))
            coordList.append((500, 580))
            coordList.append((580, 525))
            coordList.append((110, 540))
            coordList.append((290, 520))
            coordList.append((70, 450))
            coordList.append((280, 325))
            coordList.append((190, 180))
            coordList.append((170, 300))
            coordList.append((40, 245))
            coordList.append((170, 50))
            coordList.append((850, 40))
            coordList.append((560, 90))
            coordList.append((970, 105))
        } else {
            /*
            
            this list had problems with intersecting lines
            particularly when randomized
            
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
*/
            
            coordList.append((520, 300))
            coordList.append((735, 190))
            coordList.append((630, 360))
            coordList.append((225, 295))
            coordList.append((330, 225))
            coordList.append((70, 255))
            coordList.append((120, 80))
            coordList.append((410, 55))
            coordList.append((920, 90))
            coordList.append((930, 540))
            coordList.append((700, 575))
            coordList.append((740, 490))
            coordList.append((420, 585))
            coordList.append((520, 500))
            coordList.append((150, 550))
            coordList.append((60, 355))
            coordList.append((340, 400))
            coordList.append((230, 465))
            coordList.append((840, 440))
            coordList.append((770, 300))
            coordList.append((850, 130))
            coordList.append((650, 100))
            coordList.append((265, 120))
            coordList.append((445, 220))
            coordList.append((580, 185))
            
        }
        
        xt = arc4random_uniform(2000) < 1000
        yt = arc4random_uniform(2000) < 1000
        coordList = coordList.map(transform)
       
        // off will move the starting point around
        let clen = coordList.count
        let sz:Int = min(clen, names.count)
        let off = Int(arc4random_uniform(UInt32(clen)))
        for i in 0...sz-1 {
            let j = (i + off)%sz  // can do by clen, but then the bubbles are all over the screen on practice
            let coord = coordList[j]
            
            bubblelist.append((coord.0, coord.1, names[i]))
            
        }
        
        print("lst=\(lst), xt=\(xt), yt=\(yt), off=\(off)")
        
    }
    
    
    func inBubble(x:CGFloat, y:CGFloat)->Int{
        
        for (index,bubble) in bubblelist.enumerate(){
            let (a, b, _) = bubble
            
            let z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
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
        print("Found new bubble \(curr)")
        
        
        lastBubble = currentBubble
        currentBubble = curr
        
        return true
        
    }
    
    func inCorrectBubble()->Bool{
        
        if currentBubble==nextBubble {
            
            nextBubble += 1
            
            if nextBubble == bubblelist.count {
                
                timedConnectionsA.append(timePassedTrailsA)
                
                print("Done")
                nextBubble = 0
                stopTrailsA = true
                displayImgTrailsA = true
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
    
    
    
}
