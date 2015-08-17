//
//  NamingPicturesViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

class PicturesViewController: ViewController {
    
    var imageName = "House"
    var count = 0
    var corr = 0
    
    var order = [Bool]()
     var startTime2 = NSDate()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var correctButton: UIButton!
    
    @IBOutlet weak var incorrectButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
   
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBAction func HelpButton(sender: AnyObject) {
        if(selectedTest == "Naming Pictures") {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("Naming Pictures Help") as! UIViewController
            navigationController?.pushViewController(vc, animated:true)
        } else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("Famous Faces Help") as! UIViewController
            navigationController?.pushViewController(vc, animated:true)
        }
    }
    
    
    @IBAction func reset(sender: AnyObject) {
        resetButton.enabled = false
        backButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        if(count > 0) {
            done()
        }
        
        order = [Bool]()
        count = 0
        corr = 0
        imageName = getImageName()
        resultLabel.text = ""
        
        var imageView4 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image4 = UIImage(named: imageName)
        imageView4.image = image4
        self.view.addSubview(imageView4)
        
    }
    
    @IBAction func correct(sender: AnyObject) {
        if(count == 0) {
            startTime2 = NSDate()
            self.navigationItem.setHidesBackButton(true, animated:true)
            backButton.enabled = true
            resetButton.enabled = true
        }
        
        count += 1
        corr += 1
        
        if(count==15){
            resultLabel.text = "\(corr) correct out of 15"
            done()
        }
        
        imageName = getImageName()
        
        var imageView1 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image1 = UIImage(named: imageName)
        imageView1.image = image1
        self.view.addSubview(imageView1)
        
        order.append(true)
        
    }
    
    @IBAction func incorrect(sender: AnyObject) {
        if(count == 0) {
            startTime2 = NSDate()
            self.navigationItem.setHidesBackButton(true, animated:true)
            backButton.enabled = true
            resetButton.enabled = true
        }
        
        count += 1
        
        if(count==15){
            resultLabel.text = "\(corr) correct out of 15"
            done()
        }
        
        imageName = getImageName()
        
        var imageView2 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image2 = UIImage(named: imageName)
        imageView2.image = image2
        self.view.addSubview(imageView2)
        
        order.append(false)
        
    }
    
    @IBAction func back(sender: AnyObject) {
        
        count -= 1
        if count == 0 {
            resetButton.enabled = false
            backButton.enabled = false
            self.navigationItem.setHidesBackButton(false, animated:true)
        }
        if order.count > 0 {
            if order[order.count-1] == true {
                corr -= 1
            }
            
            order.removeAtIndex(order.count-1)
        }
        
        imageName = getImageName()
        
        var imageView3 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image3 = UIImage(named: imageName)
        imageView3.image = image3
        self.view.addSubview(imageView3)
        
    }
    
    func done() {
        let result = Results()
        result.name = self.title
        result.startTime = startTime2
        result.endTime = NSDate()
        result.longDescription.addObject("\(corr) correct out of \(count)")
        resultsArray.add(result)
        
        backButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedTest)
        if(selectedTest == "Naming Pictures") {
            self.title = "Naming Pictures"
        } else {
            self.title = "Famous People"
        }
        
        count = 0
        corr = 0
        imageName = getImageName()
        
        var imageView = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image = UIImage(named: imageName)
        imageView.image = image
        self.view.addSubview(imageView)
        
        backButton.enabled = false
        resetButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    func getImageName()->String{
        
        
        if(selectedTest == "Naming Pictures") {
            if(count == 0){
                return "House"//"Volcano"
            }
            if(count == 1){
                return "Comb"//"Cactus"
            }
            if(count == 2){
                return "Toothbrush"//"Park Bench"
            }
            if(count == 3){
                return "Park Bench"//"Stethoscope"
            }
            if(count == 4){
                return "Volcano"//"Mushroom"
            }
            if(count == 5){
                return "Mushroom"//"House" mushroom NOT in original order
            }
            if(count == 6){
                return "Canoe"//"Comb"
            }
            if(count == 7){
                return "Cactus"//"Unicorn"
            }
            if(count == 8){
                return "Rhino"//"Camera Tripod" rhino NOT in original order
            }
            if(count == 9){
                return "Hammock"//"Rhino"
            }
            if(count == 10){
                return "Stethoscope"//"Sphynx"
            }
            if(count == 11){
                return "Unicorn"//"Canoe"
            }
            if(count == 12){
                return "Camera Tripod"//"Toothbrush"
            }
            if(count == 13){
                return "Sphynx"
            }
            else{
                return "Palette"
            }
        } else {
            let c = count + 1
            return "FP" + String(c)
        }
        
    }
    
    
}

