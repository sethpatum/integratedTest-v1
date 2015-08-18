//
//  PatientUIViewController.swift
//  Integrated test v1
//
//  Created by saman on 8/6/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit
import MessageUI

var firstTimeThrough = true

var mailSubject : String = "CNToolkit Results"
var patientName : String?
var patientAge : String?
var patientID : String?

class PatientUIViewController: ViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var body:String?
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var IDlabel: UILabel!
    @IBOutlet weak var IDfield: UITextField!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBAction func StartTesting(sender: AnyObject) {
        if firstTimeThrough == true {
            firstTimeThrough = false
            performSegueWithIdentifier("toDisclaimer", sender: self)
        } else {
            performSegueWithIdentifier("toTestSelection", sender: self)
        }
    }
    
    
    
    @IBAction func updateName(sender: AnyObject) {
        patientName = nameField.text
    }
    
    
    @IBAction func updateAge(sender: AnyObject) {
        patientAge = ageTextField.text
    }
    
    @IBAction func updateID(sender: AnyObject) {
        patientID = IDfield.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the defaults from presistant memory
        useridOn = NSUserDefaults.standardUserDefaults().boolForKey("useridOn")
        ageOn = NSUserDefaults.standardUserDefaults().boolForKey("ageOn")
        emailOn = NSUserDefaults.standardUserDefaults().boolForKey("emailOn")
        if(NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") != nil) {
            emailAddress = NSUserDefaults.standardUserDefaults().objectForKey("emailAddress") as! String
        }
  
        IDlabel.hidden = !useridOn
        IDfield.hidden = !useridOn
        
        ageLabel.hidden = !ageOn
        ageTextField.hidden = !ageOn
        
        // Seguing here from Test selection
        if(selectedTest == "DONE") {
            if(emailOn) {
                body = resultsArray.emailBody()
                var picker = MFMailComposeViewController()
                picker.mailComposeDelegate = self
                picker.setSubject(mailSubject)
                picker.setMessageBody(body, isHTML: true)
                picker.setToRecipients([emailAddress])
                presentViewController(picker, animated: true, completion: nil)
            }
            selectedTest = ""
            resultsArray.doneWithPatient()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        body = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }


}
