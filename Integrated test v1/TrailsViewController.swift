//
//  TrailsAViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

var stopTrailsA:Bool = false

var timePassedTrailsA = 0.0
var timedConnectionsA = [Double]()
var displayImgTrailsA = false
var bubbleColor:UIColor?


class TrailsAViewController: ViewController {
    
    var drawingView: DrawingViewTrails!
    
    var imageView: UIImageView!
    
    var startTime = NSTimeInterval()
    var startTime2 = NSDate()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func StartButton(sender: AnyObject) {
        if(selectedTest == "Trails A Practice") {
            selectedTest = "Trails A"
        } else if(selectedTest == "Trails B Practice") {
            selectedTest = "Trails B"
        }
        self.title = selectedTest

        startTest()
    }
    
    
    @IBAction func PracticeButton(sender: AnyObject) {
        if(selectedTest == "Trails A") {
            selectedTest = "Trails A Practice"
        } else if(selectedTest == "Trails B") {
            selectedTest = "Trails B Practice"
        }
        self.title = selectedTest
        
        startTest()
    }

    
    func startTest() {
        
        startButton.enabled = false
        practiceButton.enabled = false
        doneButton.enabled = true
        self.navigationItem.setHidesBackButton(true, animated:true)
   
        if drawingView !== nil {
            drawingView.removeFromSuperview()
        }
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
        }
        
        timedConnectionsA = [Double]()
        
        let drawViewFrame = CGRect(x: 0.0, y: 135.0, width: view.bounds.width, height: view.bounds.height-135)
        drawingView = DrawingViewTrails(frame: drawViewFrame)
        
        print("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
                startTime2 = NSDate()
        
        //let aSelector : Selector = "update"
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "update:", userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        
        drawingView.canDraw = true
        
        bubbleColor = UIColor.redColor()
        
    }
   
    @IBAction func StopButton(sender: AnyObject) {
        
        startButton.enabled = true
        practiceButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)

        stopTrailsA = true
        done()
    }
    
    
    @IBAction func HelpButton(sender: AnyObject) {
         if(selectedTest == "Trails A" || selectedTest == "Trails A Practice") {
            let vc = storyboard!.instantiateViewControllerWithIdentifier("Trails A Help") as UIViewController
            navigationController!.pushViewController(vc, animated:true)
        } else {
            let vc = storyboard!.instantiateViewControllerWithIdentifier("Trails B Help") as UIViewController
            navigationController!.pushViewController(vc, animated:true)
        }
        stopTrailsA = true
        done()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = selectedTest
    
        doneButton.enabled = false

    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(timer: NSTimer) {
        
        if stopTrailsA == false {
            let currTime = NSDate.timeIntervalSinceReferenceDate()
            var diff: NSTimeInterval = currTime - startTime
            
            timePassedTrailsA = diff
            
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
        }
        
        if displayImgTrailsA == true {
            done()
        }
    }
    
    func done() {
        if drawingView != nil {
            drawingView.canDraw = false
            let imageSize = CGSize(width: 1024, height: 618)
            imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 135), size: imageSize))
            if resultsDisplayOn == true {
                self.view.addSubview(imageView)
            }
            let image = drawCustomImage(imageSize)
            imageView.image = image
            
            // add to results
            let result = Results()
            result.name = self.title
            result.startTime = startTime2
            result.endTime = NSDate()
            result.screenshot = image
            
            var num = timePassedTrailsA
            let minutes = UInt8(num / 60.0)
            num -= (NSTimeInterval(minutes)*60.0)
            let seconds = UInt8(num)
            num = NSTimeInterval(seconds)
            
            result.longDescription.addObject("\(drawingView.incorrect) incorrect in \(minutes) minutes and \(seconds) seconds")
            
            resultsArray.add(result)
        }
        
        displayImgTrailsA = false
        
        startButton.enabled = true
        practiceButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:false)
        
        bubbleColor = UIColor(red:0.6, green:0.0, blue:0.0, alpha:1.0)

    }
    
    
    func drawCustomImage(size: CGSize) -> UIImage {
        
        // Setup our context
        //let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        //let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        drawingView.drawResultBackground()  //background bubbles
        
        
       
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
