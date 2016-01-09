//
//  FaceNameAdaptiveMemoryViewController.swift
//  CNToolkit
//
//  Created by Seth Amarasinghe on 11/28/15.
//  Copyright © 2015 sunspot. All rights reserved.
//

import UIKit

class FaceNameAdaptiveMemoryViewController: UIViewController{
    
    var imageNames = [String]()
    
    let f0:[String] = ["F01", "F02", "F03", "F04", "F05", "F06"]
    let f1:[String] = ["Fa01", "Fa02", "Fa03", "Fa04", "Fa05", "Fa06"]
    let f2:[String] = ["Fb01", "Fb02", "Fb03", "Fb04", "Fb05", "Fb06"]
    let f3:[String] = ["Fc01", "Fc02", "Fc03", "Fc04", "Fc05", "Fc06"]
    let f4:[String] = ["Fd01", "Fd02", "Fd03", "Fd04", "Fd05", "Fd06"]
    let f5:[String] = ["Fe01", "Fe02", "Fe03", "Fe04", "Fe05", "Fe06"]
    let f6:[String] = ["Ff01", "Ff02", "Ff03", "Ff04", "Ff05", "Ff06"]
    
    let m0:[String] = ["M01", "M02", "M03", "M04", "M05", "M06"]
    let m1:[String] = ["Ma01", "Ma02", "Ma03", "Ma04", "Ma05", "Ma06"]
    let m2:[String] = ["Mb01", "Mb02", "Mb03", "Mb04", "Mb05", "Mb06"]
    let m3:[String] = ["Mc01", "Mc02", "Mc03", "Mc04", "Mc05", "Mc06"]
    let m4:[String] = ["Md01", "Md02", "Md03", "Md04", "Md05", "Md06"]
    let m5:[String] = ["Me01", "Me02", "Me03", "Me04", "Me05", "Me06"]
    let m6:[String] = ["Mf01", "Mf02", "Mf03", "Mf04", "Mf05", "Mf06"]

    
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
        
        generateList()
        
        print(imageNames)
        
        generateList()
        
        print(imageNames)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display(){
        
        
        
    }
    
    func testRecall(){
        
        
        
    }
    
    func testRecognition(){
        
        
        
    }
    
    func generateList(){
        let f = arc4random_uniform(7)
        let m = arc4random_uniform(7)
        var flist = [String]()
        var mlist = [String]()
        
        if(f==0){
            flist = f0
        }
        if(f==1){
            flist = f1
        }
        if(f==2){
            flist = f2
        }
        if(f==3){
            flist = f3
        }
        if(f==4){
            flist = f4
        }
        if(f==5){
            flist = f5
        }
        if(f==6){
            flist = f6
        }
        
        if(m==0){
            mlist = m0
        }
        if(m==1){
            mlist = m1
        }
        if(m==2){
            mlist = m2
        }
        if(m==3){
            mlist = m3
        }
        if(m==4){
            mlist = m4
        }
        if(m==5){
            mlist = m5
        }
        if(m==6){
            mlist = m6
        }
        
        imageNames = [String]()
        
        for(var k=0; k<6; k++){
            imageNames.append(flist[k])
            imageNames.append(mlist[k])
        }
        
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
