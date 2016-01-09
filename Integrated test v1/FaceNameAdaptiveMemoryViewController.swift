//
//  FaceNameAdaptiveMemoryViewController.swift
//  CNToolkit
//
//  Created by Seth Amarasinghe on 11/28/15.
//  Copyright © 2015 sunspot. All rights reserved.
//

import UIKit

class FaceNameAdaptiveMemoryViewController: UIViewController{
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
  
    @IBAction func startButton(sender: AnyObject) {
        if(selectedTest == "Face1") {
            startTest()
        } else if(selectedTest == "Face2") {
            startTest()
        }
        self.title = selectedTest
    }
    
    func startTest(){
        startButton.enabled = false
        doneButton.enabled = true
        self.navigationItem.setHidesBackButton(true, animated:false)
        

    }
    
    @IBAction func doneButton(sender: AnyObject) {
        startButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)

    }
    

    @IBOutlet weak var Done: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.enabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
