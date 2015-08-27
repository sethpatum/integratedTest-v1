//
//  SetupViewController.swift
//  Integrated test v1
//
//  Created by saman on 8/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

var useridOn : Bool = false
var ageOn    : Bool = true
var emailOn  : Bool = false
var emailAddress : String = ""
var resultsDisplayOn : Bool = true

class SetupViewController: UIViewController {

   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailOnOff: UISwitch!
    
    @IBOutlet weak var useridOnOff: UISwitch!
    
    @IBOutlet weak var AgeOnOff: UISwitch!
    
    @IBOutlet weak var resultsDisplayOnOff: UISwitch!
    
    @IBAction func emailOnOff(sender: AnyObject) {
        emailOn = emailOnOff.on
        
        email.enabled = emailOn
        NSUserDefaults.standardUserDefaults().setBool(emailOn, forKey: "emailOn")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func emailChanged(sender: AnyObject) {
        emailAddress = email.text
        NSUserDefaults.standardUserDefaults().setObject(emailAddress, forKey:"emailAddress")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    
    @IBAction func UseridOnOff(sender: AnyObject) {
        useridOn = useridOnOff.on
        NSUserDefaults.standardUserDefaults().setBool(useridOn, forKey: "useridOn")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    
    @IBAction func AgeOnOff(sender: AnyObject) {
        ageOn = AgeOnOff.on
        NSUserDefaults.standardUserDefaults().setBool(ageOn, forKey: "ageOn")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    
    @IBAction func ResultsDisplayOnOff(sender: AnyObject) {
        resultsDisplayOn = resultsDisplayOnOff.on
        NSUserDefaults.standardUserDefaults().setBool(resultsDisplayOn, forKey: "resultsDisplayOn")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        useridOn = NSUserDefaults.standardUserDefaults().boolForKey("useridOn")
        ageOn = NSUserDefaults.standardUserDefaults().boolForKey("ageOn")
        emailOn = NSUserDefaults.standardUserDefaults().boolForKey("emailOn")
        resultsDisplayOn = NSUserDefaults.standardUserDefaults().boolForKey("resultsDisplayOn")

    if(NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") != nil) {
            emailAddress = NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") as! String
        }
       
        
        email.enabled = emailOn
        emailOnOff.on = emailOn
        useridOnOff.on = useridOn
        AgeOnOff.on = ageOn
        email.text = emailAddress
        resultsDisplayOnOff.on = resultsDisplayOn
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
