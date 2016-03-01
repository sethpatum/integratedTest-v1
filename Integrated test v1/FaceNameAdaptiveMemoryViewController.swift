//
//  FaceNameAdaptiveMemoryViewController.swift
//  CNToolkit
//
//  Created by Seth Amarasinghe on 11/28/15.
//  Copyright © 2015 sunspot. All rights reserved.
//

import UIKit

class FaceNameAdaptiveMemoryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    var curr = ""
    var count = 0
    var imageNames = [String]()
    var nameList = [String]()
    var orderRecall = [Bool]()
    
    var startTime2 = NSDate()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var namePicker: UIPickerView!
    @IBOutlet weak var Done: UIButton!
   
    var imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
    
    let name1:[String] = ["Barbara", "Robert", "Eliza", "James", "Mary", "John", "Jennifer", "Michael", "Linda", "Richard", "Patricia", "Joseph"]
    let name2:[String] = ["Sarah", "Ralph", "Diane", "Andrew", "Nancy", "Fred", "Kim", "Henry", "Elizabeth", "Bill", "Joan", "Matt"]
    let name3:[String] = ["Isabella", "Ethan", "Courtney", "Jeremy", "Miriam", "Mitchell", "Jane", "Sheldon", "Dorothy", "Doug", "Carol", "Edward"]
    let name4:[String] = ["Karen", "Chris", "Betty", "Anthony", "Jessica", "Daniel", "Dana", "Donald", "Lisa", "Peter", "Sandra", "Mark"]
    let name5:[String] = ["Michelle", "Timothy", "Carol", "Brian", "Amanda", "Kenneth", "Emily", "Ronald", "Ashley", "Kevin", "Melissa", "Edward"]
    let name6:[String] = ["Jenna", "Jackson", "Caroline", "Samuel", "Sofia", "Owen", "Ella", "Evan", "Lily", "Connor", "Nathaniel", "Zoe"]
    let name7:[String] = ["Taylor", "Joshua", "Hannah", "Ryan", "Lauren", "Jacob", "Mia", "Jack", "Abigail", "Tyler", "Alexis", "Cameron"]
    
    
    
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
    
    
    
    @IBAction func startButton(sender: AnyObject) {
        startTime2 = NSDate()
        
        if(selectedTest == "Face1") {
            startTest()
        } else if(selectedTest == "Face2") {
            //startTest()
            //DO FACE 2 STUFF
        }
        self.title = selectedTest
        namePicker.hidden = true
    }
    
    func startTest(){
        startButton.enabled = false
        doneButton.enabled = true
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //        generateList()
        
        print(imageNames)
        
        display()
        
        delay(24){
            self.testRecall()
        }
        
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        startButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        namePicker.hidden = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.enabled = false
        
        generateList()
        
        namePicker.dataSource = self
        namePicker.delegate = self
        
        // Do any additional setup after loading the view.
        namePicker.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display(){
        
        namePicker.hidden = true
        
        let image = UIImage(named: imageNames[0])
        imageView.image = image
        self.view.addSubview(imageView)
        nameLabel.text = nameList[0]
        
   
        
        for i in 1...11 {
            let d = Double(i)*2.0
            delay(d){
                
                if self.imageView.image !== nil {
                    self.imageView.removeFromSuperview()
                    self.imageView.image = nil
                }
                
                self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
                let image = UIImage(named: self.imageNames[i])
                self.imageView.image = image
                self.view.addSubview(self.imageView)
                self.nameLabel.text = self.nameList[i]
            }

        }
        /*
        delay(2){
            
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            let image1 = UIImage(named: self.imageNames[1])
            self.imageView.image = image1
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[1]
        }
        
        delay(4){
            
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image2 = UIImage(named: self.imageNames[2])
            self.imageView.image = image2
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[2]
        }
        
        delay(6){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image3 = UIImage(named: self.imageNames[3])
            self.imageView.image = image3
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[3]
        }
        
        delay(8){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            let image4 = UIImage(named: self.imageNames[4])
            self.imageView.image = image4
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[4]
        }
        
        delay(10){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image5 = UIImage(named: self.imageNames[5])
            self.imageView.image = image5
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[5]
        }
        
        delay(12){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image6 = UIImage(named: self.imageNames[6])
            self.imageView.image = image6
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[6]
        }
        
        delay(14){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image7 = UIImage(named: self.imageNames[7])
            self.imageView.image = image7
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[7]
        }
        
        delay(16){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image8 = UIImage(named: self.imageNames[8])
            self.imageView.image = image8
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[8]
        }
        
        delay(18){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image9 = UIImage(named: self.imageNames[9])
            self.imageView.image = image9
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[9]
        }
        
        delay(20){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image10 = UIImage(named: self.imageNames[10])
            self.imageView.image = image10
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[10]
        }
        
        delay(22){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            self.imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))
            
            let image11 = UIImage(named: self.imageNames[11])
            self.imageView.image = image11
            self.view.addSubview(self.imageView)
            self.nameLabel.text = self.nameList[11]
        } */
        
        delay(24){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
        }
        
        
    }
    
    var nextButton : UIButton! 
    
    func testRecall(){
        
        nameLabel.text = ""
        
        namePicker.hidden = false
        
        nextButton = UIButton(type: UIButtonType.System) as UIButton
        nextButton.frame = CGRectMake(750, 580, 100, 100)
        nextButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.setTitle("Next", forState: UIControlState.Normal)
        nextButton.titleLabel!.font = UIFont(name: "Helvetica Neue", size: 29.0)
        self.view.addSubview(nextButton)
        
        
        if self.imageView.image !== nil {
            self.imageView.removeFromSuperview()
            self.imageView.image = nil
        }
        
        let image = UIImage(named: imageNames[0])
        imageView.image = image
        self.view.addSubview(imageView)
        
        count = 0
        
    }
    
    func buttonAction(sender:UIButton!){
        
        if(curr == nameList[count]){
            orderRecall.append(true)
        } else {
            orderRecall.append(false)
        }
        
        count += 1
        
        if(count == 12){
            //self.removeFromParentViewController()
            checkRecall()
            nextButton.enabled = false
        } else {
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            let image = UIImage(named: imageNames[count])
            imageView.image = image
            self.view.addSubview(imageView)
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(row == 0){
            return "--"
        }
        else{
            return nameList[row-1]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row == 0){
            curr = "--"
        }
        else{
            curr = nameList[row-1]
        }
        
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
        
        let r = arc4random_uniform(7)
        
        if(r==0){
            nameList = name1
        }
        if(r==1){
            nameList = name2
        }
        if(r==2){
            nameList = name3
        }
        if(r==3){
            nameList = name4
        }
        if(r==4){
            nameList = name5
        }
        if(r==5){
            nameList = name6
        }
        if(r==6){
            nameList = name7
        }
        
    }
    
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 13
    }
    
    func checkRecall(){
        
        if self.imageView.image !== nil {
            self.imageView.removeFromSuperview()
            self.imageView.image = nil
        }
        
        var wrong = 0
        for(var k = 0; k < orderRecall.count; k++){
            if (orderRecall[k] == false){
                wrong += 1
            }
        }
        
        resultLabel.text = "\(wrong) faces recalled incorrectly"
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        let result = Results()
        result.name = self.title
        result.startTime = startTime2
        result.endTime = NSDate()
        result.longDescription.addObject("\(wrong) faces recalled incorrectly")
        //if wrongList.count > 0  {
        //    result.longDescription.addObject("The incorrect pictures were the \(wrongList)")
        //}
        resultsArray.add(result)

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