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

class SetupViewController: UIViewController {

   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailOnOff: UISwitch!
    
    @IBOutlet weak var useridOnOff: UISwitch!
    
    @IBOutlet weak var AgeOnOff: UISwitch!
    
    
    @IBAction func emailOnOff(sender: AnyObject) {
        emailOn = emailOnOff.on
        
        email.enabled = emailOn
    }
    
    @IBAction func emailChanged(sender: AnyObject) {
        emailAddress = email.text
    }
    
    
    @IBAction func UseridOnOff(sender: AnyObject) {
        useridOn = useridOnOff.on
    }
    
    
    @IBAction func AgeOnOff(sender: AnyObject) {
        ageOn = AgeOnOff.on
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.enabled = emailOn
        emailOnOff.on = emailOn
        useridOnOff.on = useridOn
        AgeOnOff.on = ageOn
        email.text = emailAddress
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
