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
    var orderRecall = [Bool]()
    var orderRecognize = [Bool]()
    
    var recognizeKey = [Int]()
    var MaleRecognizeDisplay = [[String]]()
    
    var buttonarray = [UIButton]()
    
    var recognizeCorrect = 0
    
    
    var mfacenum = -1
    var mnamenum = -1
    
    var startTime = NSTimeInterval()
    var startTime2 = NSDate()
    var doneTimer = false
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var namePicker: UIPickerView!
    @IBOutlet weak var Done: UIButton!
   
    var imageView = UIImageView(frame:CGRectMake(350.0, 171.0, 315.0, 475.0))

    let MaleNames : [[String]] = [["Robert", "James", "John", "Michael", "Richard", "Joseph"],
        ["Ralph", "Andrew", "Fred", "Henry", "Bill", "Matt"],
        ["Ethan", "Jeremy", "Mitchell", "Sheldon", "Doug", "Edward"],
        ["Chris", "Anthony", "Daniel", "Donald", "Peter", "Mark"],
        ["Timothy", "Brian", "Kenneth", "Ronald", "Kevin","Edward"],
        ["Jackson", "Samuel", "Owen", "Evan","Connor", "Nathaniel"],
        ["Joshua", "Ryan", "Jacob", "Jack", "Tyler", "Cameron"]]
    

    let maleFaces : [[String]] = [["M01", "M02", "M03", "M04", "M05", "M06"], ["Ma01", "Ma02", "Ma03", "Ma04", "Ma05", "Ma06"], ["Mb01", "Mb02", "Mb03", "Mb04", "Mb05", "Mb06"], ["Mc01", "Mc02", "Mc03", "Mc04", "Mc05", "Mc06"], ["Md01", "Md02", "Md03", "Md04", "Md05", "Md06"], ["Me01", "Me02", "Me03", "Me04", "Me05", "Me06"], ["Mf01", "Mf02", "Mf03", "Mf04", "Mf05", "Mf06"]]
    
    var buttondisplaylist : [[String]] = []
    
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
        
        print(maleFaces[mfacenum])
        
        display()
        
        delay(12){
            self.testRecall()
        }
        
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        startButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        /*
        if namePicker.hidden == false {
            namePicker.hidden = true
        }
        */
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
        
        let image = UIImage(named: maleFaces[mfacenum][0])
        imageView.image = image
        self.view.addSubview(imageView)
        nameLabel.text = MaleNames[mnamenum][0]
        
   
        
        for i in 1...5 {
            let d = Double(i)*2.0
            delay(d){
                
                if self.imageView.image !== nil {
                    self.imageView.removeFromSuperview()
                    self.imageView.image = nil
                }
                
                self.imageView = UIImageView(frame:CGRectMake(350.0, 165.0, 315.0, 475.0))
                let image = UIImage(named: self.maleFaces[self.mfacenum][i])
                self.imageView.image = image
                self.view.addSubview(self.imageView)
                
                print("Male \(i)")
                print("\(self.maleFaces[self.mfacenum][i])")
                self.nameLabel.text = self.MaleNames[self.mnamenum][i]
            }

        }
        
        delay(12){
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
        }
        
        
    }
    
    func testRecall(){
        
        nameLabel.text = ""
        
        namePicker.hidden = false
        
        let nextButton = UIButton(type: UIButtonType.System) as UIButton
        nextButton.tag = 1
        nextButton.frame = CGRectMake(750, 580, 100, 100)
        nextButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.setTitle("Next", forState: UIControlState.Normal)
        nextButton.titleLabel!.font = UIFont(name: "Helvetica Neue", size: 29.0)
        self.view.addSubview(nextButton)
        
        
        if self.imageView.image !== nil {
            self.imageView.removeFromSuperview()
            self.imageView.image = nil
        }
        
        let image = UIImage(named: maleFaces[mfacenum][0])
        imageView.image = image
        self.view.addSubview(imageView)
        
        count = 0
        
    }
    
    func buttonAction(sender:UIButton!){
        
        let btnsend: UIButton = sender
        
        if btnsend.tag == 1 {
            
           
                if(curr == MaleNames[mnamenum][count]){
                    orderRecall.append(true)
                }
                else {
                    orderRecall.append(false)
                }
            
            count += 1
            
            if(count == 6){
                //self.removeFromParentViewController()
                checkRecall()
                //btnsend.enabled = false
                
                btnsend.removeFromSuperview()
                namePicker.removeFromSuperview()
                
                wait()
                
            } else {
                if self.imageView.image !== nil {
                    self.imageView.removeFromSuperview()
                    self.imageView.image = nil
                }
                
                let image = UIImage(named: maleFaces[mfacenum][count])
                imageView.image = image
                self.view.addSubview(imageView)
            }
        }
        
        if btnsend.tag == 2 {
            doneTimer = true
            btnsend.removeFromSuperview()
            testRecognition()
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(row == 0){
            return "--"
        }
        else {
            return MaleNames[mnamenum][row-1]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row == 0){
            curr = "--"
        }
        else{
            curr = MaleNames[mnamenum][row-1]
        }
        
    }
    
    func wait(){
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "update:", userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        let doneWait = UIButton(type: UIButtonType.System) as UIButton
        doneWait.tag = 2
        doneWait.frame = CGRectMake(363, 390, 300, 100)
        doneWait.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        doneWait.setTitle("Start Recognition", forState: UIControlState.Normal)
        doneWait.titleLabel!.font = UIFont(name: "Helvetica Neue", size: 24.0)
        self.view.addSubview(doneWait)
        
        
    }
    
    func update(timer: NSTimer) {
        
        if doneTimer == false {
            let currTime = NSDate.timeIntervalSinceReferenceDate()
            var diff: NSTimeInterval = currTime - startTime
            
            let minutes = UInt8(diff / 60.0)
            
            diff -= (NSTimeInterval(minutes)*60.0)
            
            let seconds = UInt8(diff)
            
            diff = NSTimeInterval(seconds)
            
            let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
            let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
            
            timerLabel.text = "\(strMinutes) : \(strSeconds)"
        }
        else {
            timer.invalidate()
            timerLabel.text = ""
        }
    }
    
    func testRecognition(){
        
        print("Got here!")
        MaleRecognizeDisplay = buttonlist(MaleNames[mnamenum])
        print(MaleRecognizeDisplay)
        0
        for i in 0...3 {
            
            buttonarray.append(UIButton(type: UIButtonType.System) as UIButton)
            buttonarray[i].tag = i
            buttonarray[i].frame = CGRectMake(CGFloat(150 + 200*i), 650, 120, 100)
            buttonarray[i].addTarget(self, action: "recognizeButton:", forControlEvents: UIControlEvents.TouchUpInside)
            buttonarray[i].titleLabel!.font = UIFont(name: "Helvetica Neue", size: 24.0)
            self.view.addSubview(buttonarray[i])
            
        }
        
        if self.imageView.image !== nil {
            self.imageView.removeFromSuperview()
            self.imageView.image = nil
        }
        
        let image = UIImage(named: maleFaces[mfacenum][0])
        setbuttonnames(0)
        imageView.image = image
        self.view.addSubview(imageView)
        
        count = 0
        
    }
    
    func setbuttonnames(num:Int) {
        for i in 0...3 {
            buttonarray[i].setTitle(buttondisplaylist[num][i], forState: UIControlState.Normal)
        }
    }
    
    func recognizeButton(sender:UIButton!){
        
        let btnsend: UIButton = sender
        
        if (btnsend.tag == recognizeKey[count]){
            recognizeCorrect += 1
        }
        
        count += 1
        
        if(count < 6) {
            setbuttonnames(count)
            
            if self.imageView.image !== nil {
                self.imageView.removeFromSuperview()
                self.imageView.image = nil
            }
            
            let image = UIImage(named: maleFaces[mfacenum][count])
            imageView.image = image
            self.view.addSubview(imageView)
        } else {
             for i in 0...3 {
                buttonarray[i].hidden = true
            }
        }
    }
    
    
    // Create all the lists needed
    func generateList(){
        mfacenum = Int(arc4random_uniform(7))
        mnamenum = Int(arc4random_uniform(7))
        buttondisplaylist = buttonlist(MaleNames[mnamenum])
        recognizeKey = findinlist(buttondisplaylist, name : MaleNames[mnamenum])
        
    }
    
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
    }
    
    
    // given a list of names, create a list of lists where each sublist k is garuntee to have the kth input name plus 
    // 3 other names, all randomly arranged
    func buttonlist(names :[String]) -> [[String]] {
        
        var blist : [[String]] = []
        for index in names.indices {
            var curr = names
            let corr = curr.removeAtIndex(index)
            var buttons:[String] = []
            buttons.append(corr)
            for _ in 1...3 {
                let next = arc4random_uniform(UInt32(curr.count))
                let rest = curr.removeAtIndex(Int(next))
                buttons.append(rest)
            }
            buttons = buttons.shuffle()
            blist.append(buttons)
        }
        return blist
    }
    
    // The list is a list of list, each list k has the name[k] as an element, output list indicates the index of it
    func findinlist(list :[[String]], name:[String]) -> [Int] {
        var ret : [Int] = []
        for index in name.indices {
            ret.append(list[index].indexOf(name[index])!)
        }
        return ret
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    
    func checkRecall(){
        
        if self.imageView.image !== nil {
            self.imageView.removeFromSuperview()
            self.imageView.image = nil
        }
        
        var wrong = 0
        for k in orderRecall.indices {
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
    
    func checkRecognition(){
        resultLabel.text = "\(recognizeCorrect) faces recognized correctly"
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

extension CollectionType {
    
    /// Return a copy of `self` with its elements shuffled
    
    func shuffle() -> [Generator.Element] {
        
        var list = Array(self)
        
        list.shuffleInPlace()
        
        return list
        
    }
    
}



extension MutableCollectionType where Index == Int {
    
    /// Shuffle the elements of `self` in-place.
    
    mutating func shuffleInPlace() {
        
        // empty and single-element collections don't shuffle
        
        if count < 2 { return }
        
        
        
        for i in 0..<count - 1 {
            
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            
            guard i != j else { continue }
            
            swap(&self[i], &self[j])
            
        }
        
    }
    
}
