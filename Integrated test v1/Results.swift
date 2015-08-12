//
//  Results.swift
//  Integrated test v1
//
//  Created by saman on 8/8/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

var resultsArray : NSMutableArray = NSMutableArray()

class Results: NSObject {
    var name:String?
    var startTime:NSDate?
    var endTime:NSDate?
    var shortDescription:String?
    var longDescription : NSMutableArray = NSMutableArray()
    var screenshot : UIImage?
    
    // Constructor
    func Results(nm:String, st:NSDate, en:NSDate) {
        name = nm
        startTime = st
        endTime = en
    }
    
    // Return the string function to put on the header
    func header() -> String {
        let elapsedTime = endTime!.timeIntervalSinceDate(startTime!)
        let duration = Int(elapsedTime)
        return name! + " (" + String(duration) + "): " + shortDescription!
    }
    
    
    // Number of rows should be long description + one if there is a screenshot
    func numRows() -> Int {
        if screenshot == nil {
            return longDescription.count
        } else {
            return longDescription.count + 1
        }
    }
    
    
    // All rows are same height, except the screeshot
    func heightForRaw(i:Int) -> Int {
        if i < longDescription.count {
            return 100
        }
        if i == longDescription.count && screenshot != nil {
            return 1000
        }
        return 0
    }
    
    
    // either a text row are a screenshot raw
    func setRow(i:Int, cell:UITableViewCell) {
        if i < longDescription.count {
            cell.textLabel?.text = longDescription.objectAtIndex(i) as? String
        }
        if i == longDescription.count && screenshot != nil {
            cell.imageView?.image = screenshot
        }
        
    }
    
    func TakeScreeshot() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext())
        screenshot = UIGraphicsGetImageFromCurrentImageContext()
    }
    
   
}
