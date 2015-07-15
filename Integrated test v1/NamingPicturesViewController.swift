//
//  NamingPicturesViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

class NamingPicturesViewController: UIViewController {
    
    var imageName = "Volcano"
    var count = 0
    var corr = 0
    var wasCorrect = true
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func reset(sender: AnyObject) {
        
        count = 0
        corr = 0
        wasCorrect = true
        imageName = "Volcano"
        resultLabel.text = ""
        
        var imageView4 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image4 = UIImage(named: imageName)
        imageView4.image = image4
        self.view.addSubview(imageView4)
        
    }
    
    @IBAction func correct(sender: AnyObject) {
        
        count += 1
        corr += 1
        wasCorrect = true
        
        if(count==15){
            resultLabel.text = "\(corr) correct out of 15"
        }
        
        imageName = getImageName()
        
        var imageView1 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image1 = UIImage(named: imageName)
        imageView1.image = image1
        self.view.addSubview(imageView1)
        
    }
    
    @IBAction func incorrect(sender: AnyObject) {
        
        count += 1
        wasCorrect = false
        
        if(count==15){
            resultLabel.text = "\(corr) correct out of 15"
        }
        
        imageName = getImageName()
        
        var imageView2 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image2 = UIImage(named: imageName)
        imageView2.image = image2
        self.view.addSubview(imageView2)
        
    }
    
    @IBAction func back(sender: AnyObject) {
        
        count -= 1
        if (wasCorrect==true){
            corr -= 1
        }
        
        imageName = getImageName()
        
        var imageView3 = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image3 = UIImage(named: imageName)
        imageView3.image = image3
        self.view.addSubview(imageView3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageView = UIImageView(frame:CGRectMake(107.0, 171.0, 800.0, 600.0))
        
        var image = UIImage(named: imageName)
        imageView.image = image
        self.view.addSubview(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    func getImageName()->String{
        
        if(count == 0){
            return "Volcano"
        }
        if(count == 1){
            return "Cactus"
        }
        if(count == 2){
            return "Park Bench"
        }
        if(count == 3){
            return "Stethoscope"
        }
        if(count == 4){
            return "Mushroom"
        }
        if(count == 5){
            return "House"
        }
        if(count == 6){
            return "Comb"
        }
        if(count == 7){
            return "Unicorn"
        }
        if(count == 8){
            return "Camera Tripod"
        }
        if(count == 9){
            return "Rhino"
        }
        if(count == 10){
            return "Sphynx"
        }
        if(count == 11){
            return "Canoe"
        }
        if(count == 12){
            return "Toothbrush"
        }
        if(count == 13){
            return "Palette"
        }
        else{
            return "Hammock"
        }
        
    }
    
    
}

