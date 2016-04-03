//
//  Circles.swift
//  Integrated test v1
//
//  Created by School on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import Foundation
import UIKit
import Darwin



class Circles{
    
    var circlelist = [(Int, Int, Int, UIColor)]()
    var resultListIndexes = [Int]()
    var resultListCircles = [(Int, Int, Int)]()
    var resultListTimesCircles = [Double]()
    
    init(){
        
        
    }
    
    
    func randomizeList(){
        
        var circlelist1 = [(Int, Int, Int)]()
        
        circlelist = [(Int, Int, Int, UIColor)]()
        
        circlelist1.append((70, 30, 0)) //CHANGED
        circlelist1.append((320, 40, 2)) //left
        circlelist1.append((480, 80, 1)) //left
        circlelist1.append((140, 110, 0))
        circlelist1.append((250, 90, 2)) //left
        circlelist1.append((395, 140, 0))
        circlelist1.append((50, 190, 1)) //left
        circlelist1.append((70, 270, 0))
        circlelist1.append((200, 225, 0))
        circlelist1.append((340, 205, 2)) //left
        circlelist1.append((460, 235, 0))
        circlelist1.append((110, 370, 2)) //left
        circlelist1.append((190, 330, 0))
        circlelist1.append((305, 310, 1)) //left CHANGED
        circlelist1.append((440, 330, 0))
        circlelist1.append((245, 455, 2)) //CHANGED
        circlelist1.append((400, 430, 1))
        circlelist1.append((40, 510, 1))
        circlelist1.append((310, 500, 0))
        circlelist1.append((140, 590, 2))
        circlelist1.append((250, 570, 1))
        
        var circlelist2 = [(Int, Int, Int)]()
        circlelist2.append((640, 100, 0))
        circlelist2.append((830, 50, 1))
        circlelist2.append((560, 180, 2)) //right CHANGED
        circlelist2.append((710, 180, 1)) //right
        circlelist2.append((785, 165, 1)) //right CHANGED
        circlelist2.append((650, 275, 2)) //right
        circlelist2.append((810, 270, 0))
        circlelist2.append((920, 355, 0))
        circlelist2.append((950, 150, 1)) //right
        circlelist2.append((520, 360, 0))
        circlelist2.append((615, 405, 2)) // CHANGED
        circlelist2.append((830, 380, 0)) //CHANGED
        circlelist2.append((725, 380, 0)) // CHANGED
        circlelist2.append((920, 450, 2))
        circlelist2.append((540, 500, 2)) //
        circlelist2.append((660, 535, 0)) //
        circlelist2.append((950, 540, 0))
        circlelist2.append((465, 580, 1)) //
        circlelist2.append((585, 590, 0)) // CHANGED
        circlelist2.append((860, 585, 1))
        circlelist2.append((770, 505, 2))
        
        var array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]
        var length = 21
        
        for(_, circle) in circlelist1.enumerate(){
            let (a,b,_) = circle
            
            let random = arc4random_uniform(UInt32(length))
            
            print(random)
            
            let i = array[Int(random)]
            
            circlelist.append((a,b,i, UIColor(hue: 0.66, saturation: 0.7, brightness: 0.4, alpha: 1.0)))
            
            print(i)
            
            let r = Int(random)
            
            array.removeAtIndex(r)
            
            print(array)
            
            length = length - 1
            
        }
        
        var array2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]
        var length2 = 21
        
        for(_, circle) in circlelist2.enumerate(){
            let (a,b,_) = circle
            
            let random = arc4random_uniform(UInt32(length2))
            
            let i = array2[Int(random)]
            
            circlelist.append((a,b,i, UIColor(hue: 0.66, saturation: 0.7, brightness: 0.4, alpha: 1.0)))
            
            let r = Int(random)
            
            array2.removeAtIndex(r)
            
            length2 = length2 - 1
            
        }
        
        print(circlelist)
        
        
    }
    
    func inCircle(x:CGFloat, y:CGFloat)->Int{
        
        for (index,circle) in circlelist.enumerate(){
            let (a, b, _, _) = circle
            
            let z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
            if z <= 850.0 {
                return index
            }
            
        }
        
        return -1
    }
    
    func inNewCircle(x:CGFloat, y:CGFloat) {
        let curr = inCircle(x, y:y)
        
        for var k = 0; k < resultListIndexes.count; ++k {
            
            if curr == resultListIndexes[k] {
                return
            }
            
        }
        
        if curr == -1 {
            return
        }
        
        let (a, b, c, _) = circlelist[curr]
        
        resultListCircles.append(a, b, c)
        resultListIndexes.append(curr)
        
        resultListTimesCircles.append(timePassedCircles)
        
        
    }
    
    func checkResultList(result:Results){
        
        for (_, circle) in resultListCircles.enumerate(){
            
            let(a,b,c) = circle
            
            print("x = \(a), y = \(b), c = \(c)")
            
        }
        
        var correctOnLeft = 0
        var correctOnRight = 0
        var incorrectLeftSemiOnLeft = 0
        var incorrectRightSemiOnLeft = 0
        var incorrectLeftSemiOnRight = 0
        var incorrectRightSemiOnRight = 0
        
        for var i = 0; i < circlelist.count; ++i {
            let (_, _, c, _) = circlelist[i]
            if (c == 0) {
                circlelist[i].3 = UIColor(hue: 0.66, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            }
        }
        
        for var k = 0; k < resultListIndexes.count; ++k {
            
            let (a, _, c) = resultListCircles[k]
            
            if c == 0 && a < 500 {
                correctOnLeft += 1
                circlelist[resultListIndexes[k]].3 = UIColor(hue: 0.33, saturation: 1.0, brightness: 0.70, alpha: 1.0)
            }
            
            if c == 0 && a >= 500 {
                correctOnRight += 1
                circlelist[resultListIndexes[k]].3 = UIColor(hue: 0.33, saturation: 1.0, brightness: 0.70, alpha: 1.0)
            }
            
            
            if c == 1 && a < 500 {
                incorrectLeftSemiOnLeft += 1
                circlelist[resultListIndexes[k]].3 = UIColor(hue: 0.0, saturation: 1.0, brightness: 0.70, alpha: 1.0)
            }
            
            if c == 1 && a >= 500 {
                incorrectLeftSemiOnRight += 1
                circlelist[resultListIndexes[k]].3 = UIColor(hue: 0.0, saturation: 1.0, brightness: 0.70, alpha: 1.0)
            }
            
            if c == 2 && a < 500 {
                incorrectRightSemiOnLeft += 1
                circlelist[resultListIndexes[k]].3 = UIColor(hue: 0.0, saturation: 1.0, brightness: 0.70, alpha: 1.0)
            }
            
            if c == 2 && a >= 500 {
                incorrectRightSemiOnRight += 1
                circlelist[resultListIndexes[k]].3 = UIColor(hue: 0.0, saturation: 1.0, brightness: 0.70, alpha: 1.0)
            }
            
        }
        
        result.longDescription.addObject("\(correctOnLeft) out of 12 complete circles crossed off on left half;")
        result.longDescription.addObject("\(correctOnRight) out of 12 complete circles crossed off on right half.")
        result.longDescription.addObject("\(incorrectLeftSemiOnLeft) incorrect (Left facing semicircles) crossed off on left;")
        result.longDescription.addObject("\(incorrectRightSemiOnLeft) incorrect (Right facing semicircles) crossed off on left;")
        result.longDescription.addObject("\(incorrectLeftSemiOnRight) incorrect (Left facing semicircles) crossed off on right.")
        result.longDescription.addObject("\(incorrectRightSemiOnRight) incorrect (Right facing semicircles) crossed off on right.")

        //resultTextCircles = "\(correctOnLeft) out of 12 semicircles crossed off on left half; \(correctOnRight) out of 12 semicircles crossed off on right half. \n\(leftSemiCircles) out of 12 left-halved semicircles crossed off; \(rightSemiCircles) out of 12 right-halved semicircles crossed off. \n\(incorrect) full circles incorrectly crossed off."
        
        print(resultListTimesCircles)
        
        for var k = 1; k < resultListTimesCircles.count; ++k{
            
            let (a, b, _) = resultListCircles[k-1]
            let (x, y, _) = resultListCircles[k]
            let i = resultListTimesCircles[k] - resultListTimesCircles[k-1]
            
            print("From x = \(a), y = \(b) to x = \(x), y = \(y), time = \(i)")
            
            timedConnections.append(a, b, x, y, i)
            
        }
        
        resultListIndexes = [Int]()
        resultListCircles = [(Int, Int, Int)]()
        resultListTimesCircles = [Double]()
        
    }
    
    
    
}