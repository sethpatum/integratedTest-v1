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
    
    var circlelist = [(Int, Int, Int)]()
    var resultListIndexes = [Int]()
    var resultListCircles = [(Int, Int, Int)]()
    
    var resultListTimes = [Double]()
    
    init(){
        
        
    }
    
    
    func randomizeList(){
        
        var circlelist1 = [(Int, Int, Int)]()
        
        circlelist = [(Int, Int, Int)]()
        
        circlelist1.append((140, 30, 0)) //CHANGED
        circlelist1.append((320, 40, 2)) //left
        circlelist1.append((480, 80, 1)) //left
        circlelist1.append((100, 110, 0))
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
        circlelist2.append((555, 520, 2)) //
        circlelist2.append((650, 535, 0)) //
        circlelist2.append((950, 540, 0))
        circlelist2.append((465, 580, 1)) //
        circlelist2.append((585, 610, 0)) // CHANGED
        circlelist2.append((860, 590, 1))
        circlelist2.append((770, 505, 2))
        
        var array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]
        var length = 21
        
        for(index, circle) in enumerate(circlelist1){
            let (a,b,c) = circle
            
            let random = arc4random_uniform(UInt32(length))
            
            println(random)
            
            let i = array[Int(random)]
            
            circlelist.append((a,b,i))
            
            println(i)
            
            var r = Int(random)
            
            array.removeAtIndex(r)
            
            println(array)
            
            length = length - 1
            
        }
        
        var array2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2]
        var length2 = 21
        
        for(index, circle) in enumerate(circlelist2){
            let (a,b,c) = circle
            
            let random = arc4random_uniform(UInt32(length2))
            
            let i = array2[Int(random)]
            
            circlelist.append((a,b,i))
            
            var r = Int(random)
            
            array2.removeAtIndex(r)
            
            length2 = length2 - 1
            
        }
        
        println(circlelist)
        
        
    }
    
    func inCircle(x:CGFloat, y:CGFloat)->Int{
        
        for (index,circle) in enumerate(circlelist){
            let (a, b, c) = circle
            
            var z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
            if z <= 700.0 {
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
        
        resultListCircles.append(circlelist[curr])
        resultListIndexes.append(curr)
        
        resultListTimes.append(timePassedCircles)
        
        
    }
    
    func checkResultList(){
        
        for (index, circle) in enumerate(resultListCircles){
            
            let(a,b,c) = circle
            
            println("x = \(a), y = \(b), c = \(c)")
            
        }
        
        var correctOnLeft = 0
        var correctOnRight = 0
        var leftSemiCircles = 0
        var rightSemiCircles = 0
        var incorrect = 0
        
        for (index, circle) in enumerate(resultListCircles){
            let(a,b,c) = circle
            
            if c != 0{
                
                if a<500{
                    correctOnLeft += 1
                }
                    
                else{
                    correctOnRight += 1
                }
                
                if c == 1{
                    leftSemiCircles += 1
                }
                if c == 2{
                    rightSemiCircles += 1
                }
                
            }
                
            else {
                incorrect += 1
            }
            
            
        }
        
        println("\(correctOnLeft) out of 12 semicircles crossed off on left half; \(correctOnRight) out of 12 semicircles crossed off on right half.\n\(leftSemiCircles) out of 12 left-halved semicircles crossed off; \(rightSemiCircles) out of 12 right-halved semicircles crossed off.\n\(incorrect) full circles incorrectly crossed off.")
        
        
        resultTextCircles = "\(correctOnLeft) out of 12 semicircles crossed off on left half; \(correctOnRight) out of 12 semicircles crossed off on right half. \n\(leftSemiCircles) out of 12 left-halved semicircles crossed off; \(rightSemiCircles) out of 12 right-halved semicircles crossed off. \n\(incorrect) full circles incorrectly crossed off."
        
        println(resultListTimes)
        
        for var k = 1; k < resultListTimes.count; ++k{
            
            let (a, b, c) = resultListCircles[k-1]
            let (x, y, z) = resultListCircles[k]
            let i = resultListTimes[k] - resultListTimes[k-1]
            
            println("From x = \(a), y = \(b) to x = \(x), y = \(y), time = \(i)")
            
            timedConnections.append(a, b, x, y, i)
            
        }
        
        resultListIndexes = [Int]()
        resultListCircles = [(Int, Int, Int)]()
        resultListTimes = [Double]()
        
    }
    
    
    
}