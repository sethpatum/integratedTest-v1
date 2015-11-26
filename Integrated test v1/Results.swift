//
//  Results.swift
//  Integrated test v1
//
//  Created by saman on 8/8/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

var resultsArray : AllResults = AllResults()

class Results: NSObject {
    var name:String?
    var startTime:NSDate?
    var endTime:NSDate?
    var shortDescription:String?
    var longDescription : NSMutableArray = NSMutableArray()
    var screenshot : UIImage?
    
    var collapsed : Bool = true // for use by the View Controller
    
    // Constructor
    func Results(nm:String, startTime:NSDate, endTime:NSDate) {
        name = nm
        self.startTime = startTime
        self.endTime = endTime
    }
    
    // Return the string function to put on the header
    func header() -> String {
        let elapsedTime = endTime!.timeIntervalSinceDate(startTime!)
        let duration = Int(elapsedTime)
        if shortDescription == nil {
            return name! + " (" + String(duration) + " secs): "
        } else {
            return name! + " (" + String(duration) + " secs): " + shortDescription!
        }
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
    func heightForRow(i:Int) -> Int {
        if i < longDescription.count {
             return 60
        }
        if i == longDescription.count && screenshot != nil {
            return 500
        }
        return 0
    }
    
    
    // either a text row are a screenshot raw
    func setRow(i:Int, cell:UITableViewCell) {
        if i < longDescription.count {
            cell.textLabel?.text = longDescription.objectAtIndex(i) as? String
            cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell.textLabel?.numberOfLines = 0
        }
        if i == longDescription.count && screenshot != nil {
            cell.imageView?.image = screenshot
            cell.textLabel?.text = nil
        } else {
            cell.imageView?.image = nil
        }
        
    }
    
    func TakeScreeshot() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        screenshot = UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func displayLocal(view:UIView?, imageView:UIImageView?, results:UILabel) {
        if resultsDisplayOn == true {
            if view != nil && imageView != nil {
                view!.addSubview(imageView!)
            }
            var str:String = ""
            for info in longDescription {
                str += info as! String
                str += "\n"
            }
            results.text = str
        }
        
    }
   
}
