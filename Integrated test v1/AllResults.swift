//
//  AllResults.swift
//  Integrated test v1
//
//  Created by saman on 8/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit
import MessageUI

class AllResults  {
    
    var results:NSMutableArray = NSMutableArray()
    
    
     func get(index: Int) -> Results {
        return results.objectAtIndex(index) as! Results
    }
    
    func add(res:Results) {
        results.addObject(res)
    }
    func numResults() -> Int {
        return results.count
    }
    
    func doneWithPatient() {
        results.removeAllObjects()
    }
   
}
