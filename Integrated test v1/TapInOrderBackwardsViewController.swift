//
//  TapInOrderBackwardsViewController.swift
//  Integrated test v1
//
//  Created by School on 7/15/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//


import UIKit
import Darwin

class TapInOrderBackwardsViewController: UIViewController {
    
    
    var buttonList = [UIButton]()
    var places:[(Int,Int)] = [(100, 250), (450, 300), (350, 500), (600, 450), (800, 200), (700, 650), (850, 550), (200, 350), (100, 600), (300, 650)]
    //SHORTER LIST FOR TESTING: var places:[(Int,Int)] = [(100, 200), (450, 250), (350, 450), (600, 400)]
    var order = [Int]() //randomized order of buttons
    var numplaces = 0 //current # of buttons that light up in a row, -1
    var currpressed = 0 //order of button that is about to be pressed
    var numRepeats = 0 //how many times user messed up on the same numplaces, calling repeat()
    
    var startTime2 = NSDate()
    
    var ended = false
    
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    //start from 1st button; reset all info
    @IBAction func Reset(sender: AnyObject) {
        
        println("in reset")
        
        numplaces = 0
        numRepeats = 0
        currpressed = 0
        self.resultsLabel.text = ""
        
        randomizeOrder()
        
        for (index, i) in enumerate(self.order) {
            self.buttonList[index].backgroundColor = UIColor.redColor()
        }
        
        delay(1.5){
            self.drawSequenceRecursively(self.numplaces)
            self.startTime2 = NSDate()
        }
        
    }
    
    //allow buttons to be pressed
    func enableButtons() {
        for (index, i) in enumerate(order) {
            buttonList[index].addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    //stop buttons from being pressed
    func disableButtons() {
        for (index, i) in enumerate(order) {
            buttonList[index].removeTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            println("buttons disabled")
            
        }
    }
    
    //changes 'order' and 'buttonList' arrays, adds buttons; called in next, reset and viewDidLoad
    func randomizeOrder() {
        
        println("randomizing order")
        
        order = [Int]()
        //numplaces = 0
        
        var array = [Int]()
        for i in 0...places.count-1 {
            array.append(i)
        }
        
        for var k=places.count-1; k>=0; --k{
            var random = Int(arc4random_uniform(UInt32(k)))
            order.append(array[random])
            array.removeAtIndex(random)
        }
        
        buttonList = [UIButton]()
        
        for (index, i) in enumerate(order) {
            let(a,b) = places[i]
            
            var x : CGFloat = CGFloat(a)
            var y : CGFloat = CGFloat(b)
            
            let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            buttonList.append(button)
            button.frame = CGRectMake(x, y, 50, 50)
            button.backgroundColor = UIColor.redColor()
            self.view.addSubview(button)
            
        }
        
        println("order is \(order)")
    }
    
    //randomize 1st order; light up 1st button
    override func viewDidLoad() {
        
        super.viewDidLoad()
        endButton.enabled = false
        resetButton.enabled = false
        
        randomizeOrder()
       
    }
    
    @IBAction func StartTest(sender: AnyObject) {
        
        ended = false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        helpButton.enabled = false
        StartButton.enabled = false
        endButton.enabled = true
        resetButton.enabled = true
        
        numplaces = 0
        numRepeats = 0
        
        randomizeOrder()
        
        drawSequenceRecursively(numplaces)
        startTime2 = NSDate()
        currpressed = 0

        self.resultsLabel.text = ""
    }
    
    
    @IBAction func endButton(sender: AnyObject) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        helpButton.enabled = true
        StartButton.enabled = true
        endButton.enabled = false
        resetButton.enabled = false
        
        donetest()

    }
    @IBAction func helpBhutton(sender: AnyObject) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        helpButton.enabled = true
        StartButton.enabled = true
        endButton.enabled = false
        resetButton.enabled = false
        
        numplaces = 0
        numRepeats = 0
        //donetest()
    }
    
    func donetest() {
        
        ended = true
        
        delay(0.5) {
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.helpButton.enabled = true
            self.StartButton.enabled = true
            self.endButton.enabled = false
            self.resetButton.enabled = false
            
            let result = Results()
            result.name = "Backward Spatial Span"
            result.startTime = self.startTime2
            result.endTime = NSDate()
            for (index, i) in enumerate(self.order) {
                self.buttonList[index].backgroundColor = UIColor.darkGrayColor()
                
                if resultsDisplayOn == true {
                    self.resultsLabel.text = "Spatial span: \(self.numplaces)"
                }
                
                let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
            }
            result.longDescription.addObject("Backward spatial span: \(self.numplaces)")
            
            resultsArray.add(result)
            
            self.numplaces = 0
            self.numRepeats = 0
            
        }
    }
    
    //light up the right # of buttons (numplaces+1) for current sequence; buttons enabled AFTER all light up
    /*
    func drawsequence() {
        
        println("drawing sequence")
        
        
        for (index, i) in enumerate(order) {
            if index <= numplaces {
                println("Setting \(index) to button \(i)")
                
                //THIS IS WHAT MAKES IT PLAY THE ORDER BACKWARDS:
                
                var delayTime:Double = Double(numplaces+1-(index))
                
                delay(delayTime){
                    self.buttonList[index].backgroundColor = UIColor.greenColor()
                }
                delay(delayTime+1){
                    self.buttonList[index].backgroundColor = UIColor.redColor()
                    println("Drawing \(index)")
                    
                }
                
            }
        }
        //enable buttons once finished lighting up
        
        delay(Double(numplaces+2)) {
            println("...enabling buttons...numplaces = \(self.numplaces+2)")
            self.enableButtons()
        }
        
    }
    */
    func drawSequenceRecursively(num:Int){
        
        if num < 0 {
            self.enableButtons()
        }
        
        else {
            
            if ended == false {
                delay(0.4) {
                    if self.ended == false {
                        self.buttonList[num].backgroundColor = UIColor.greenColor()
                        println("green; num = \(num)")
                        self.delay(1.0){
                            if self.ended == false {
                                self.buttonList[num].backgroundColor = UIColor.redColor()
                                println("red; num = \(num)")
                                /*
                                for (index, i) in enumerate(self.order) {
                                    self.buttonList[index].backgroundColor = UIColor.redColor()
                                }
*/
                                
                                println("Getting here shoudl be red")
                                
                                var num2 = num - 1
                                self.drawSequenceRecursively(num2)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //call when a mistake is made (-> repeat(), or finish if repeated already)
    //OR call when finished sequence (-> next() if numplaces is not maxxed out, otherwise finish)
    func selectionDone(n:Int, status:Bool) {
        
        disableButtons()
        
        println("selection done")
        
        //false means user hit incorrect button
        if status == false {
            
            if numRepeats < 1 {
                repeat()
            }
                
                //if user has already repeated this level color changes to gray and test finishes
            else{
                /*
                for (index, i) in enumerate(order) {
                buttonList[index].backgroundColor = UIColor.darkGrayColor()
                }
                */
                //account for delay when changing black back to red for most recently pressed button
                donetest()
            }
            
        }
            //true means user finished the sequence correctly up to numplaces
            //if numplaces is not maxxed out, light up one more button (-> next()), otherwise finish w/ perfect score
        else {
            
            if numplaces < buttonList.count-1{
                
                delay(1.0){
                    self.next()
                }
                
            }
            else {
                /*
                for (index, i) in enumerate(order) {
                buttonList[index].backgroundColor = UIColor.darkGrayColor()
                }
                */
                //account for delay when changing black back to red for most recently pressed button
                donetest()
            }
            
        }
        
        println("Done in \(n)! \(status)")
    }
    
    //user messed up; replay same sequence
    func repeat(){
        //change color to gray to indicate mistake
        /*
        for (index, i) in enumerate(order) {
        buttonList[index].backgroundColor = UIColor.lightGrayColor()
        }
        */
        //account for delay when changing black back to red for most recently pressed button
        delay(0.5) {
            
            if self.ended == false {
                for (index, i) in enumerate(self.order) {
                    self.buttonList[index].backgroundColor = UIColor.lightGrayColor()
                }
            }
            
        }
        
        //return color to normal, currpressed to zero (restarting that sequence), record the repeat, light up buttons
        delay(2.5) {
            
            if self.ended == false {
                println("in repeat")
                for (index, i) in enumerate(self.order) {
                    self.buttonList[index].backgroundColor = UIColor.redColor()
                }
                
                self.currpressed = 0
                self.numRepeats += 1
                self.drawSequenceRecursively(self.numplaces)
            }
            
        }
        
        
    }
    
    //user completed sequence; reset repeats, increase numplaces so 1 more button lights up
    func next(){
        numplaces = numplaces + 1
        delay(1) {
            if self.ended == false {
                println("next")
                self.numRepeats = 0
                self.currpressed = 0
                self.randomizeOrder()
                self.drawSequenceRecursively(self.numplaces)
            }
        }
        
    }
    
    //what happens when a user taps a button (if buttons are enabled at the time)
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
        
        //find which button user has tapped
        for i in 0...buttonList.count-1 {
            if sender == buttonList[i] {
                println("In button \(i)")
                
                //change color to indicate tap
                sender.backgroundColor = UIColor.blackColor()
                
                delay(0.5) {
                    sender.backgroundColor = UIColor.redColor()
                }
                
                //get out of loop if it's the wrong button; will eventually lead to repeat()
                if i != currpressed {
                    println("BA: Problem \(i) is not \(currpressed)")
                    selectionDone(i, status:false)
                    return
                }
                    //if it's the right button AND it's the last in the current sequence exit loop; will eventually go to next()
                else if currpressed == numplaces {
                    println("BA: at end of list cp=\(currpressed) i=\(i) - all OK")
                    selectionDone(i, status:true)
                    return
                }
                println("BA: \(i) is good")
                
                //if it's the correct button but there are more in sequence, curpressed increases by 1 to check next tap
                currpressed = currpressed + 1
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    //delay function
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
    
    
}

