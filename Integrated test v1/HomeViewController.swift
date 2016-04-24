//
//  HomeViewController.swift
//  CNToolkit
//
//  Created by Saman Amarasinghe on 8/30/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit
var screenSize : CGRect?


class HomeViewController: ViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        let build = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String
        
        versionLabel.text = "Version " + version! + " (build " + build! + ")"
        screenSize = UIScreen.mainScreen().bounds
        print(screenSize)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
