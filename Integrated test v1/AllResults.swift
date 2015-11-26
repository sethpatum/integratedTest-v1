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
    
    // Get the results at # index
    func get(index: Int) -> Results {
        return results.objectAtIndex(index) as! Results
    }
    
    // add new results at end of the list
    func add(res:Results) {
        results.addObject(res)
    }
    
    // How many results are in the list
    func numResults() -> Int {
        return results.count
    }
    
    // Remove all the results
    func doneWithPatient() {
        results.removeAllObjects()
    }
    
    
    // convert theresults to an e-mail
    func emailBody() -> String {
        var e:String = ""
        
        // See what information we got on the patient
        if(nameOn && patientName != nil) {
            e += "<p><h4>Patient Name: \(patientName!)</h4>\n"
        }
        
        if(ageOn && patientAge != nil) {
            e += "<h4>Patient Age:  \(patientAge!)</h4>\n"
        }
        
        if(useridOn && patientID != nil) {
            e += "<h4>Patient ID: \(patientID!) </h4>\n"
        }
         e += "<p>\n"
        
        
        if(bdateOn && patientBdate != nil) {
            e += "<h4>Patient Birthdate: \(patientBdate!) </h4>\n"
        }
        e += "<p>\n"
        
        // Iterate over the results
        if(numResults() > 0) {
            for i in 0...numResults()-1 {
                let r = get(i)
                e += "<h2>\(i+1)) \(r.name!)</h2><p>\n"
                
                if(r.shortDescription != nil){
                    e += "\(r.shortDescription)<p>\n"
                }
                
                let elapsedTime = r.endTime!.timeIntervalSinceDate(r.startTime!)
                let duration = Int(elapsedTime)
                e += "\(duration) seconds taken. (Test run on \(r.startTime!))<p>\n"
                
                for objs in r.longDescription {
                    if let desc = objs as? String {
                        e += "\(desc)<p>\n"
                    }
                }
                
                if(r.screenshot != nil) {
                    let imageString = returnEmailStringBase64EncodedImage(r.screenshot!)
                    e += "<img src='data:image/png;base64,\(imageString)' width='\(r.screenshot!.size.width)' height='\(r.screenshot!.size.height)'><p>\n"
                }
            }
        }
        
        // Put the time scale at the end of the e-mail
        let scaleImage = UIImage(named: "scale")
        let imageString = returnEmailStringBase64EncodedImage(scaleImage!)
        e += "<p> <h3>scale</h3>\n"
        e += "<img src='data:image/png;base64,\(imageString)' width='\(scaleImage!.size.width)' height='\(scaleImage!.size.height)'><p>\n"
        
        return e
    }
    
    func returnEmailStringBase64EncodedImage(image:UIImage) -> String {
        //BUGBUG: Fix this!!
        let imgData:NSData = UIImagePNGRepresentation(image)!;
        let dataString = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return dataString
    }
}
