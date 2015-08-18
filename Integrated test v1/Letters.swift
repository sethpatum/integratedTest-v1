//
//  Letters.swift
//  Integrated test v1
//
//  Created by School on 7/15/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import Foundation
import UIKit


class Letters{
    
    var letterlist = [(Int, Int, String)]()
    var resultListIndexes = [Int]()
    var resultListX = [Int]()
    var resultListLetters = [String]()
    var resultListTimes = [Double]()
    
    init(){
    }
    
    func randomize(){
        
        var letterlist1 = [(Int, Int, String)]()
        
        letterlist = [(Int, Int, String)]()
        
        letterlist1.append((150, 80, "N"))
        letterlist1.append((150, 180, "E"))
        letterlist1.append((150, 280, "A"))
        letterlist1.append((150, 380, "E"))
        letterlist1.append((150, 480, "W"))
        letterlist1.append((250, 80, "B"))
        letterlist1.append((250, 180, "V"))
        letterlist1.append((250, 280, "A"))
        letterlist1.append((250, 380, "H"))
        letterlist1.append((250, 480, "X"))
        letterlist1.append((350, 80, "Z"))
        letterlist1.append((350, 180, "R"))
        letterlist1.append((350, 280, "U"))
        letterlist1.append((350, 380, "A"))
        letterlist1.append((350, 480, "E"))
        letterlist1.append((450, 80, "L"))
        letterlist1.append((450, 180, "S"))
        letterlist1.append((450, 280, "R"))
        letterlist1.append((450, 380, "Q"))
        letterlist1.append((450, 480, "I"))
        
        var letterlist2 = [(Int, Int, String)]()
        
        letterlist2.append((550, 80, "O"))
        letterlist2.append((550, 180, "B"))
        letterlist2.append((550, 280, "E"))
        letterlist2.append((550, 380, "G"))
        letterlist2.append((550, 480, "A"))
        letterlist2.append((650, 80, "P"))
        letterlist2.append((650, 180, "K"))
        letterlist2.append((650, 280, "E"))
        letterlist2.append((650, 380, "B"))
        letterlist2.append((650, 480, "W"))
        letterlist2.append((750, 80, "R"))
        letterlist2.append((750, 180, "Q"))
        letterlist2.append((750, 280, "W"))
        letterlist2.append((750, 380, "E"))
        letterlist2.append((750, 480, "Y"))
        letterlist2.append((850, 80, "T"))
        letterlist2.append((850, 180, "R"))
        letterlist2.append((850, 280, "P"))
        letterlist2.append((850, 380, "W"))
        letterlist2.append((850, 480, "X"))
        
        var array = ["N", "E", "A", "E", "W", "B", "V", "A", "H", "X", "Z", "R", "U", "A", "E", "L", "S", "R", "Q", "I"]
        var length = 20
        
        for(index, letter) in enumerate(letterlist1){
            
            let (a,b,c) = letter
            
            let random = arc4random_uniform(UInt32(length))
            
            let i = array[Int(random)]
            
            letterlist.append((a,b,i))
            
            println(i)
            
            var r = Int(random)
            
            array.removeAtIndex(r)
            
            println(array)
            
            length = length - 1
            
        }
        
        var array2 = ["O", "B", "E", "G", "A", "P", "K", "E", "B", "W", "R", "Q", "W", "E", "Y", "T", "R", "P", "W", "X"]
        var length2 = 20
        
        for(index, letter) in enumerate(letterlist2){
            
            let(a,b,c) = letter
            
            let random = arc4random_uniform(UInt32(length2))
            
            let i = array2[Int(random)]
            
            letterlist.append((a,b,i))
            
            println(i)
            
            var r = Int(random)
            
            array2.removeAtIndex(r)
            
            println(array2)
            
            length2 = length2 - 1
            
        }
        
    }
    
    func inLetter(x:CGFloat, y:CGFloat)->Int{
        
        println("In inLetter")
        for (index,letter) in enumerate(letterlist){
            let (a, b, c) = letter
            
            var z = (x-CGFloat(a))*(x-CGFloat(a)) + (y-CGFloat(b))*(y-CGFloat(b))
            
            var i: CGFloat = CGFloat(450 + ((fontLetters - 20)*18))
            
            println(i)
            
            if z <= i {
                println("returned index to inNewLetter")
                return index
            }
            
        }
        
        println("returned -1 to inNewLetter")
        return -1
    }
    
    func inNewLetter(x:CGFloat, y:CGFloat) {
        println("in inNewLetter")
        
        let curr = inLetter(x, y:y)
        
        for var k = 0; k < resultListIndexes.count; ++k {
            
            if curr == resultListIndexes[k] {
                println("inNewLetter says not in new letter")
                return
            }
            
        }
        
        if curr == -1 {
            println("inNewLetter says not in new letter")
            return
        }
        
        resultListIndexes.append(curr)
        
        let (a,b,c) = letterlist[curr]
        
        resultListX.append(a)
        resultListLetters.append(c)
        
        println("added \(c) to resultListLetters")
        
        resultListTimes.append(timePassedLetters)
        
    }
    
    func checkResultListLetters(result:Results){
        
        for var j = 0; j < resultListLetters.count; ++j {
            println(resultListLetters[j])
        }
        
        
        var correctOnRight = 0
        var correctOnLeft = 0
        var incorrect = 0
        
        for var k = 0; k < resultListIndexes.count; ++k {
            if (resultListLetters[k]==("E") || resultListLetters[k]==("R")) {
                
                if resultListX[k] < 500 {
                    correctOnLeft += 1
                }
                else {
                    correctOnRight += 1
                }
                
            }
                
            else {
                incorrect += 1
            }
            
        }
        
        //resultTextLetters = "\(correctOnRight) correct out of 5 on right; \(correctOnLeft) correct out of 5 on left; \(incorrect) incorrect."
        result.longDescription.addObject("\(correctOnRight) correct out of 5 on right;")
        result.longDescription.addObject("\(correctOnLeft) correct out of 5 on left;")
        result.longDescription.addObject("\(incorrect) incorrect.")

        
        for var k = 1; k < resultListTimes.count; ++k{
            
            let (a, b, c) = letterlist[resultListIndexes[k-1]]
            let (x, y, z) = letterlist[resultListIndexes[k]]
            let i = resultListTimes[k] - resultListTimes[k-1]
            
            println("From x = \(a), y = \(b) to x = \(x), y = \(y), time = \(i)")
            
            timedConnectionsLetters.append(a, b, x, y, i)
            
        }
        
        
        resultListIndexes = [Int]()
        resultListX = [Int]()
        resultListLetters = [String]()
        resultListTimes = [Double]()
        
    }
    
    
}