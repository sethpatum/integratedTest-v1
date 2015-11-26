//
//  PyramidsAndPalmsViewController.swift
//  CNToolkit
//
//  Created by School on 8/26/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import Foundation


import UIKit

class PyramidsAndPalmsViewController: UIViewController {
    
    
    var imageList = [(UIImage, UIImage, UIImage)]()
    var imageView = UIImageView()
    var button1 = UIButton()
    var button2 = UIButton()
    var resultList = [Int]()
    var place = 0
    var order = [Int]()
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let glasses = UIImage(named: "glasses") as UIImage!
        let eye = UIImage(named: "eye") as UIImage!
        let ear = UIImage(named: "ear") as UIImage!
        imageList.append((glasses, eye, ear))
        
        let matches = UIImage(named: "matches") as UIImage!
        let lightbulb = UIImage(named: "lightbulb") as UIImage!
        let candle = UIImage(named: "candle") as UIImage!
        imageList.append((matches, lightbulb, candle))
        
        let doghouse = UIImage(named: "doghouse") as UIImage!
        let dog = UIImage(named: "dog") as UIImage!
        let cat = UIImage(named: "cat") as UIImage!
        imageList.append((doghouse, dog, cat))
        
        let puddle = UIImage(named: "puddle") as UIImage!
        let cloud = UIImage(named: "cloud") as UIImage!
        let sun = UIImage(named: "sun") as UIImage!
        imageList.append((puddle, cloud, sun))
        
        let baby = UIImage(named: "baby") as UIImage!
        let bed = UIImage(named: "bed") as UIImage!
        let crib = UIImage(named: "crib") as UIImage!
        imageList.append((baby, bed, crib))
        
        order = [1, 2, 1, 1, 2]
        
        button1 = UIButton(type: UIButtonType.Custom)
        button2 = UIButton(type: UIButtonType.Custom)
        
    }
    
    @IBAction func Start(sender: AnyObject) {
        
        resultList = [Int]()
        place = 0
        resultLabel.text = ""
        promptLabel.text = "Which fits best with the picture on top?"
        
        if imageView.image !== nil {
            imageView.removeFromSuperview()
            imageView.image = nil
        }
        
        
        let (a, b, c) = imageList[0]
        
        let s = a.size
        let w = s.width / 1.5
        let h = s.height / 1.5
        
        imageView = UIImageView(frame: CGRectMake(350, 140, w, h))
        imageView.image = a
        self.view.addSubview(imageView)
        
        
        
        let s1 = b.size
        let w1 = s1.width / 1.5
        let h1 = s1.height / 1.5
        
        button1.frame = CGRectMake(75, 470, w1, h1)
        button1.setImage(b, forState: UIControlState.Normal)
        button1.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button1)
        
        
        
        
        let s2 = c.size
        let w2 = s2.width / 1.5
        let h2 = s2.height / 1.5
        
        button2.frame = CGRectMake(650, 470, w2, h2)
        button2.setImage(c, forState: UIControlState.Normal)
        button2.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2)
        
    }
    
    
    func buttonAction(sender:UIButton!){
        
        if sender == button1 {
            resultList.append(1)
        }
        if sender == button2 {
            resultList.append(2)
        }
        
        place += 1
        
        print("place is \(place), result list is \(resultList)")
        
        if place >= imageList.count {
            checkList()
        }
            
        else {
            
            
            let (a, b, c) = imageList[place]
            
            let s = a.size
            let w = s.width / 1.5
            let h = s.height / 1.5
            
            if imageView.image !== nil {
                imageView.removeFromSuperview()
                imageView.image = nil
            }
            
            imageView = UIImageView(frame: CGRectMake(350, 140, w, h))
            imageView.image = a
            self.view.addSubview(imageView)
            
            
            
            //button1 = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            
            let s1 = b.size
            let w1 = s1.width / 1.5
            let h1 = s1.height / 1.5
            
            button1.frame = CGRectMake(75, 470, w1, h1)
            button1.setImage(b, forState: UIControlState.Normal)
            button1.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button1)
            
            
            
            //button2 = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            
            let s2 = c.size
            let w2 = s2.width / 1.5
            let h2 = s2.height / 1.5
            
            button2.frame = CGRectMake(650, 470, w2, h2)
            button2.setImage(c, forState: UIControlState.Normal)
            button2.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button2)
            
            
        }
        
    }
    
    func checkList(){
        
        var incorrect = [Int]()
        var incorrectString = "Levels "
        
        for var k = 0; k < order.count; ++k {
            
            if order[k] != resultList[k] {
                incorrect.append(k+1)
            }
            
        }
        
        for var j = 0; j < incorrect.count; ++j {
            
            if incorrect.count == 1 {
                incorrectString = "Level \(incorrect[j])"
            }
            else{
                if(j == incorrect.count - 1){
                    incorrectString += "and \(incorrect[j])"
                }
                else {
                    incorrectString += "\(incorrect[j]) "
                }
            }
            
        }
        
        if incorrect.count > 0 {
            incorrectString += " incorrect"
        }
        else {
            incorrectString = "All levels correct"
        }
        
        resultLabel.text = incorrectString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
}

