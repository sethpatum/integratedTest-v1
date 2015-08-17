//
//  TestSelectionTableViewController.swift
//  Integrated test v1
//
//  Created by saman on 8/13/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit



var selectedTest:String?

class TestSelectionTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        selectedTest = segue.identifier
    }
}
