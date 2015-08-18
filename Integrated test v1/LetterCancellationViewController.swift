//
//  LetterCancellationViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

var resultTextLetters = ""
var fontLetters = 20
var stopLetters:Bool = false
var timePassedLetters = 0.0
var timedConnectionsLetters = [(Int, Int, Int, Int, Double)]()

import UIKit


class LetterCancellationViewController: ViewController {
    
    var drawingView: DrawingViewLetters!
    
        
    @IBOutlet weak var fontLabel: UILabel! //done
    
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    
    var imageView: UIImageView!
    
    var startTime = NSTimeInterval()
    var startTime2 = NSDate()
    
    
    @IBAction func sizeChanged(sender: UISlider) {
        
        var currentValue = Int(sender.value)
        
        fontLetters = currentValue
        fontLabel.text = "Adjust font size: \(currentValue)"
        
    }
    
    @IBAction func StartButton(sender: AnyObject) {
        
        startButton.enabled = false
        doneButton.enabled = true
        self.navigationItem.setHidesBackButton(true, animated:true)

        if drawingView !== nil {
            
            drawingView.removeFromSuperview()
        }
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
        }
        
        timedConnectionsLetters = [(Int, Int, Int, Int, Double)]()
        letters.resultListIndexes = [Int]()
        letters.resultListX = [Int]()
        letters.resultListLetters = [String]()
        letters.resultListTimes = [Double]()
        
        let drawViewFrame = CGRect(x: 0.0, y: 200.0, width: view.bounds.width, height: view.bounds.height-200.0)
        drawingView = DrawingViewLetters(frame: drawViewFrame)
        
        println("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
        var timer = NSTimer()
        startTime2 = NSDate()
        
        let aSelector : Selector = "update"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "update:", userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        stopLetters = false
        
    }
    
    @IBAction func StopButton(sender: AnyObject){
        
        startButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        let result = Results()
        
        stopLetters = true
        
        letters.checkResultListLetters(result)
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        screenShotMethod()
        
        resultTextLetters = ""
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
            println("should have removed image")
        }
        
        let imageSize = CGSize(width: 1024, height: 558)
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 210), size: imageSize))
        self.view.addSubview(imageView)
        let image = drawCustomImage(imageSize)
        imageView.image = image
        
        // add to results
        result.name = "Letter Cancellation"
        result.startTime = startTime2
        result.endTime = NSDate()
        result.screenshot = image
        resultsArray.add(result)
        
    }
    
    func drawCustomImage(size: CGSize) -> UIImage {
        println(timedConnectionsLetters)
        
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        
        if (timedConnectionsLetters.count > 0){
            
            for var k = 0; k < timedConnectionsLetters.count; ++k {
                
                let (a, b, x, y, z) = timedConnectionsLetters[k]
                
                println("a = \(a) b = \(b) x = \(x) y = \(y) z = \(z)")
                
                CGContextSetStrokeColorWithColor(context, getColor(z))
                
                CGContextBeginPath(context)
                CGContextSetLineWidth(context, 7.0)
                
                CGContextMoveToPoint(context, CGFloat(a-5), CGFloat(b+5))
                CGContextAddLineToPoint(context, CGFloat(x-5), CGFloat(y+5))
                
                CGContextStrokePath(context)
                
                if k > 0 {
                    
                    println("getting here")
                    
                    let (a2, b2, x2, y2, z2) = timedConnectionsLetters[k-1]
                    
                    CGContextSetFillColorWithColor(context, getColor(z2))
                    
                    CGContextBeginPath(context)
                    CGContextSetLineWidth(context, 7.0)
                    
                    CGContextMoveToPoint(context, CGFloat(a2-5), CGFloat(b2+5))
                    
                    let r = CGRect(x: a2-15, y: b2-5, width: 20, height: 20)
                    CGContextFillEllipseInRect(context, r)
                    
                    CGContextFillPath(context)
                    
                }
            }
            
            let (a3, b3, x3, y3, z3) = timedConnectionsLetters[timedConnectionsLetters.count-1]
            let r3 = CGRect(x: a3-15, y: b3-5, width: 20, height: 20)
            CGContextSetFillColorWithColor(context, getColor(z3))
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, CGFloat(a3-5), CGFloat(b3+5))
            CGContextFillEllipseInRect(context, r3)
            
            let r4 = CGRect(x: x3-15, y: y3-5, width: 20, height: 20)
            CGContextMoveToPoint(context, CGFloat(x3-5), CGFloat(y3+5))
            CGContextFillEllipseInRect(context, r4)
            
            CGContextFillPath(context)
            
        }
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         doneButton.enabled = false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
    func update(timer: NSTimer) {
        
        if stopLetters == false{
            var currTime = NSDate.timeIntervalSinceReferenceDate()
            var diff: NSTimeInterval = currTime - startTime
            
            timePassedLetters = diff
            
            //delete after this
            
            let minutes = UInt8(diff / 60.0)
            
            diff -= (NSTimeInterval(minutes)*60.0)
            
            let seconds = UInt8(diff)
            
            diff = NSTimeInterval(seconds)
            
            let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
            let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
            
            println("\(strMinutes) : \(strSeconds)")
        }
        else {
            timer.invalidate()
        }
        
        
    }
    
    
    
}

