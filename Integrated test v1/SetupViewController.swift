//
//  SetupViewController.swift
//  Integrated test v1
//
//  Created by saman on 8/16/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

var nameOn   : Bool = true
var useridOn : Bool = false
var ageOn    : Bool = false
var bdateOn  : Bool = true
var emailOn  : Bool = false
var emailAddress : String = ""
var resultsDisplayOn : Bool = true

class SetupViewController: ViewController {

   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailOnOff: UISwitch!
    
    @IBOutlet weak var nameOnOff: UISwitch!
    
    @IBOutlet weak var useridOnOff: UISwitch!
    
    @IBOutlet weak var AgeOnOff: UISwitch!
    
    @IBOutlet weak var birthdateOnOff: UISwitch!
    
    @IBOutlet weak var resultsDisplayOnOff: UISwitch!
    
    @IBAction func emailOnOff(sender: AnyObject) {
        emailOn = emailOnOff.on
        
        email.enabled = emailOn
        NSUserDefaults.standardUserDefaults().setBool(!emailOn, forKey: "emailOff")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func emailChanged(sender: AnyObject) {
        emailAddress = email.text!
        NSUserDefaults.standardUserDefaults().setObject(emailAddress, forKey:"emailAddress")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    @IBAction func nameOnOff(sender: AnyObject) {
        nameOn = nameOnOff.on
        NSUserDefaults.standardUserDefaults().setBool(!nameOn, forKey: "nameOff")
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
        
        if ageOn && bdateOn {
            bdateOn = false
            birthdateOnOff.on = bdateOn
            NSUserDefaults.standardUserDefaults().setBool(!bdateOn, forKey: "bdateOff")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    @IBAction func BdateOnOff(sender: AnyObject) {
        bdateOn = birthdateOnOff.on
        NSUserDefaults.standardUserDefaults().setBool(!bdateOn, forKey: "bdateOff")
        NSUserDefaults.standardUserDefaults().synchronize()
        if ageOn && bdateOn {
            ageOn = false
            AgeOnOff.on = ageOn
            NSUserDefaults.standardUserDefaults().setBool(ageOn, forKey: "ageOn")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    @IBAction func ResultsDisplayOnOff(sender: AnyObject) {
        resultsDisplayOn = resultsDisplayOnOff.on
        NSUserDefaults.standardUserDefaults().setBool(!resultsDisplayOn, forKey: "resultsDisplayOff")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOn = !NSUserDefaults.standardUserDefaults().boolForKey("nameOff")
        useridOn = NSUserDefaults.standardUserDefaults().boolForKey("useridOn")
        ageOn = NSUserDefaults.standardUserDefaults().boolForKey("ageOn")
        emailOn = !NSUserDefaults.standardUserDefaults().boolForKey("emailOff")
        bdateOn = !NSUserDefaults.standardUserDefaults().boolForKey("bdateOff")
        resultsDisplayOn = !NSUserDefaults.standardUserDefaults().boolForKey("resultsDisplayOff")

        if(NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") != nil) {
            emailAddress = NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") as! String
        }
       
        
        email.enabled = emailOn
        emailOnOff.on = emailOn
        nameOnOff.on = nameOn
        useridOnOff.on = useridOn
        AgeOnOff.on = ageOn
        birthdateOnOff.on = bdateOn
        email.text = emailAddress
        resultsDisplayOnOff.on = resultsDisplayOn
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
