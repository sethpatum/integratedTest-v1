//
//  ViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getColor(i: Double, alpha: Double = 1.0) ->CGColor {
        if (i < 5.0) {
            let h = CGFloat(0.3 - i / 15.0)
            return UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: CGFloat(alpha)).CGColor
        } else if (i < 60) {
            let b = CGFloat((60.0 - i)/55.0)
            return UIColor(hue: 0.0, saturation: 1.0, brightness: b, alpha: CGFloat(alpha)).CGColor
        } else {
            return UIColor(hue: 0.0, saturation: 1.0, brightness: 0.0, alpha: CGFloat(alpha)).CGColor
        }
    }
}

