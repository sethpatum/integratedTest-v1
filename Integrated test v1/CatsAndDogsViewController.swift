//
//  CatsAndDogsViewController.swift
//  CatsAndDogs
//
//  Created by School on 7/25/16.
//  Copyright © 2016 sunspot. All rights reserved.
//

import UIKit

import Darwin

class CatsAndDogsViewController: ViewController {
    
    var buttonList = [UIButton]()
    var imageList = [UIImageView]()
    var places:[(Int,Int)] = [(150, 250), (450, 300), (350, 500), (600, 450), (800, 200), (700, 650), (850, 550), (250, 350), (150, 600), (300, 650)]
    //SHORTER LIST FOR TESTING: var places:[(Int,Int)] = [(100, 200), (450, 250), (350, 450), (600, 400)]
    var order = [Int]() //randomized order of buttons
    
    var pressed = [Int]()
    var correctDogs = [Int]()
    var missedDogs = [Int]()
    var incorrectCats = [Int]()
    var missedCats = [Int]()
    var incorrectRandom = [Int]()
    var times = [Double]()
    
    var timePassed = Double()
    
    var canDisplayAfterAlert = false
    
    var startTime = NSTimeInterval()
    var startTime2 = NSDate()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var cats = 0 //# cats
    var dogs = 1 //# dogs
    var level = 0 //current level
    var repetition = 0
    
    var ended = false
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var selectionDoneButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    //start from 1st button; reset all info
    
    @IBAction func Reset(sender: AnyObject) {
        print("in reset")
        
        cats = 0
        dogs = 1
        level = 0
        
        self.resultsLabel.text = ""
        
        randomizeOrder()
        
        for (index, _) in self.order.enumerate() {
            self.buttonList[index].backgroundColor = UIColor.blueColor()
        }
        
        delay(1.5){
            
            self.display()
            self.startTime2 = NSDate()
        }
        
    }
    
    //allow buttons to be pressed
    func enableButtons() {
        
        for (index, _) in order.enumerate() {
            buttonList[index].addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        print("buttons enabled")
    }
    
    //stop buttons from being pressed
    func disableButtons() {
        for (index, _) in order.enumerate() {
            buttonList[index].removeTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        print("buttons disabled")
    }
    
    
    //Rotate (180 degrees) or mirror (on x or y) the point
    var xt:Bool = true
    var yt:Bool = true
    func transform(coord:(Int, Int)) -> (Int, Int) {
        var x = coord.0
        var y = coord.1
        if xt  {
            x  = 950 - x
        }
        if yt {
            y = 850 - y
        }
        
        //return (Int(CGFloat(x)*screenSize!.maxX/1024.0), Int(CGFloat(y)*screenSize!.maxY/768.0))
        return (x, y)
    }
    
    
    func randomizeBoard() {
        xt = arc4random_uniform(2000) < 1000
        yt = arc4random_uniform(2000) < 1000
        places = places.map(transform)
    }
    
    
    //changes 'order' and 'buttonList' arrays, adds buttons; called in next, reset and viewDidLoad
    func randomizeOrder() {
        
        print("randomizing order")
        
        order = [Int]()
        //numplaces = 0
        
        var array = [Int]()
        for i in 0...places.count-1 {
            array.append(i)
        }
        
        for var k=places.count-1; k>=0; --k{
            let random = Int(arc4random_uniform(UInt32(k)))
            order.append(array[random])
            array.removeAtIndex(random)
        }
        
        
        print("order is \(order)")
        
        
    }
    
    //randomize 1st order; light up 1st button
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Cats And Dogs"
        
        endButton.enabled = false
        resetButton.enabled = false
        selectionDoneButton.enabled = false
        
        randomizeBoard()
        
        randomizeOrder()
        
        for(var i = 0; i < order.count; i++) {
            let(a,b) = places[order[i]]
            
            let x : CGFloat = CGFloat(a)
            let y : CGFloat = CGFloat(b)
            
            if(i <= dogs - 1) {
                
                let image = UIImage(named: "dogpic")!
                let imageView = UIImageView(frame:CGRectMake(x, y, 100.0*(image.size.width)/(image.size.height), 100.0))
                imageView.image = image
                self.view.addSubview(imageView)
                imageList.append(imageView)
                
            }
                
            else {
                if(i <= cats + dogs - 1) {
                    
                    let image = UIImage(named: "catpic")!
                    let imageView = UIImageView(frame:CGRectMake(x, y, 100.0*(image.size.width)/(image.size.height), 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    imageList.append(imageView)
                    
                }
            }
            
            let button = UIButton(type: UIButtonType.System)
            buttonList.append(button)
            button.frame = CGRectMake(x, y, 100, 100)
            button.backgroundColor = UIColor.blueColor()
            self.view.addSubview(button)
            
        }
        
    }
    
    
    @IBAction func StartTest(sender: AnyObject) {
        delay(1.5){}
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "update:", userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        ended = false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        helpButton.enabled = false
        startButton.enabled = false
        selectionDoneButton.enabled = false
        endButton.enabled = true
        resetButton.enabled = true
        
        level = 0
        cats = 0
        dogs = 1
        
        delay(1.0){
            self.display()
            self.startTime2 = NSDate()
        }
        
        self.resultsLabel.text = ""
    }
    
    
    @IBAction func EndTest(sender: AnyObject) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        helpButton.enabled = true
        startButton.enabled = true
        endButton.enabled = false
        resetButton.enabled = false
        selectionDoneButton.enabled = false
        donetest()
        
    }
    
    func drawstart() {
        
    }
    
    func donetest() {
        
        ended = true
        
        for(var k = 0; k < buttonList.count; k++){
            buttonList[k].removeFromSuperview()
        }
        for(var j = 0; j < imageList.count; j++){
            imageList[j].removeFromSuperview()
        }
        
        delay(0.5) {
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.helpButton.enabled = true
            self.startButton.enabled = true
            self.endButton.enabled = false
            self.resetButton.enabled = false
            self.selectionDoneButton.enabled = false
            
            for (index, _) in self.order.enumerate() {
                self.buttonList[index].backgroundColor = UIColor.darkGrayColor()
                
            }
            
            var result = ""
            
            for(var k=0; k<level; k++){
                result += "\(self.correctDogs[k]) dogs correctly selected out of \(self.missedDogs[k]+self.correctDogs[k]) dogs; \(self.incorrectCats[k]) cats incorrectly selected out of \(self.incorrectCats[k]+self.missedCats[k]) cats; \(self.incorrectRandom[k]) empty places incorrectly selected. Time: \(self.times[k]) seconds\n"
            }
            
            self.resultLabel.text = result
            
            
            
        }
    }
    
    func display(){
        print("Displaying...")
        for(var index = 0; index < order.count; index++){
            UIView.animateWithDuration(0.5, animations:{
                self.buttonList[index].frame = CGRectMake(self.buttonList[index].frame.origin.x - 110, self.buttonList[index].frame.origin.y, self.buttonList[index].frame.size.width, self.buttonList[index].frame.size.height)
            })
        }
        
        delay(1.25){
            for(var index = 0; index < self.order.count; index++){
                UIView.animateWithDuration(0.5, animations:{
                    self.buttonList[index].frame = CGRectMake(self.buttonList[index].frame.origin.x + 110, self.buttonList[index].frame.origin.y, self.buttonList[index].frame.size.width, self.buttonList[index].frame.size.height)
                })
            }
            self.enableButtons()
            self.startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    
    @IBAction func selectionDone(sender: AnyObject) {
        
        disableButtons()
        selectionDoneButton.enabled = false
        
        times.append(timePassed)
        timePassed = 0
        
        print("selection done; dogs = \(dogs), cats = \(cats)")
        
        var dogCount = 0
        var catCount = 0
        var otherCount = 0
        for(var k = 0; k < pressed.count; k++){
            if(pressed[k] < dogs){
                dogCount++
            }
            else {
                if(pressed[k] < dogs + cats){
                    catCount++
                }
                else {
                    otherCount++
                }
            }
        }
        
        pressed = [Int]()
        
        print("catCount = \(catCount), dogCount = \(dogCount), otherCount = \(otherCount), time = \(timePassed)")
        correctDogs.append(dogCount)
        missedDogs.append(dogs-dogCount)
        incorrectCats.append(catCount)
        missedCats.append(cats-catCount)
        incorrectRandom.append(otherCount)
        
        next()
        
    }
    
    //user completed sequence; reset repeats, increase numplaces so 1 more button lights up
    func next(){
        
        level++
        
        print("next; level = \(level)")
        
        if (level == 25){
            if(repetition<0) {
                level = 0
                repetition++
            }
            else {
                donetest()
            }
        }
            
        else {
            
            if(level == 0){
                alert("Tap all the dogs")
                cats = 0
                dogs = 1
            }
            if(level == 1){
                cats = 0
                dogs = 2
            }
            if(level == 2){
                cats = 0
                dogs = 3
            }
            if(level == 3){
                cats = 0
                dogs = 4
            }
            if(level == 4){
                cats = 0
                dogs = 5
            }
            
            if(level == 5){
                alert("Tap all the dogs.\nDo NOT tap the cats")
                cats = 2
                dogs = 1
            }
            if(level == 6){
                cats = 2
                dogs = 2
            }
            if(level == 7){
                cats = 2
                dogs = 3
            }
            if(level == 8){
                cats = 2
                dogs = 4
            }
            if(level == 9){
                cats = 2
                dogs = 5
            }
            
            if(level == 10){
                cats = 4
                dogs = 1
            }
            if(level == 11){
                cats = 4
                dogs = 2
            }
            if(level == 12){
                cats = 4
                dogs = 3
            }
            if(level == 13){
                cats = 4
                dogs = 4
            }
            if(level == 14){
                cats = 4
                dogs = 5
            }
            
            if(level == 15){
                alert("Tap all the cats.\nDo NOT tap the dogs")
                dogs = 2
                cats = 1
            }
            if(level == 16){
                dogs = 2
                cats = 2
            }
            if(level == 17){
                dogs = 2
                cats = 3
            }
            if(level == 18){
                dogs = 2
                cats = 4
            }
            if(level == 19){
                dogs = 2
                cats = 5
            }
            
            if(level == 20){
                dogs = 4
                cats = 1
            }
            if(level == 21){
                dogs = 4
                cats = 2
            }
            if(level == 22){
                dogs = 4
                cats = 3
            }
            if(level == 23){
                dogs = 4
                cats = 4
            }
            if(level == 24){
                dogs = 4
                cats = 5
            }
            
            randomizeOrder()
            print("order randomized; cats = \(cats), dogs = \(dogs)")
            
            for(var k = 0; k < buttonList.count; k++){
                buttonList[k].removeFromSuperview()
            }
            for(var k = 0; k < imageList.count; k++){
                imageList[k].removeFromSuperview()
            }
            buttonList = [UIButton]()
            imageList = [UIImageView]()
            
            for(var i = 0; i < order.count; i++) {
                let(a,b) = places[order[i]]
                
                let x : CGFloat = CGFloat(a)
                let y : CGFloat = CGFloat(b)
                
                if(i <= dogs - 1) {
                    
                    let image = UIImage(named: "dogpic")!
                    let imageView = UIImageView(frame:CGRectMake(x, y, 100.0*(image.size.width)/(image.size.height), 100.0))
                    imageView.image = image
                    self.view.addSubview(imageView)
                    imageList.append(imageView)
                    
                    //print("shoulda added dog images")
                    
                }
                    
                else {
                    if(i <= cats + dogs - 1) {
                        
                        let image = UIImage(named: "catpic")!
                        let imageView = UIImageView(frame:CGRectMake(x, y, 100.0*(image.size.width)/(image.size.height), 100.0))
                        imageView.image = image
                        self.view.addSubview(imageView)
                        imageList.append(imageView)
                        
                        //print("shoulda added cat images")
                        
                    }
                }
                
                let button = UIButton(type: UIButtonType.System)
                buttonList.append(button)
                button.frame = CGRectMake(x, y, 100, 100)
                button.backgroundColor = UIColor.blueColor()
                self.view.addSubview(button)
                
                //print("shoulda added buttons")
                
            }
            
            if(level != 0 && level != 5 && level != 15){
                display()
            }
            
        }
    }
    
    //what happens when a user taps a button (if buttons are enabled at the time)
    
    func buttonAction(sender:UIButton!)
    {
        
        //print("Button tapped")
        
        selectionDoneButton.enabled = true
        
        timePassed = findTime()
        
        //find which button user has tapped
        for i in 0...buttonList.count-1 {
            if sender == buttonList[i] {
                print("In button \(i)")
                
                //change color to indicate tap
                sender.backgroundColor = UIColor.darkGrayColor()
                sender.enabled = false
                
                pressed.append(i)
                
                
            }
        }
        
    }
    
    func alert(info:String){
        let alert = UIAlertController(title: "Instructions", message: info, preferredStyle: .Alert)
        /*
        //2. Add the text field. You can configure it however you need.
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
        textField.text = ""
        
        })
        */
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.canDisplayAfterAlert = true
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func update(timer: NSTimer) {
        
        if(canDisplayAfterAlert == true){
            canDisplayAfterAlert = false
            display()
        }
        
    }
    
    func findTime()->Double{
        
        let currTime = NSDate.timeIntervalSinceReferenceDate()
        var diff: NSTimeInterval = currTime - startTime
        print(diff)
        let minutes = UInt8(diff / 60.0)
        diff -= (NSTimeInterval(minutes)*60.0)
        let seconds = Double(diff)
        return seconds
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    //delay function
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
}