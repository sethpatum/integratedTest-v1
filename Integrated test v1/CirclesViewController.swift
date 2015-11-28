//
//  CirclesViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//

import UIKit

var resultTextCircles = ""
var stopCircles:Bool = false
var timePassedCircles = 0.0



//[(Circle 1's x value, y value, circle 2's x, y, time between crosses)]
var timedConnections = [(Int, Int, Int, Int, Double)]()

class CirclesViewController: ViewController {
    
    var drawingView: DrawingViewCircles!
    var imageView: UIImageView!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var startTime = NSTimeInterval()
    var startTime2 = NSDate()
    
    @IBAction func HelpButton(sender: AnyObject) {
        startButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        let result = Results()
        
        
        stopCircles = true
        
        circles.checkResultList(result)
        
        resultTextCircles = ""
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
            print("should have removed image")
        }
        
        let imageSize = CGSize(width: 1024, height: 638)
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 130), size: imageSize))
        result.displayLocal(self.view, imageView:imageView, results:self.resultsLabel)
        let image = drawCustomImage(imageSize)
        imageView.image = image
        
        // add to results
        result.name = "OTA Cancellation"
        result.startTime = startTime2
        result.endTime = NSDate()
        result.screenshot = image
        resultsArray.add(result)
        

        
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
        
        timedConnections = [(Int, Int, Int, Int, Double)]()
        circles.resultListTimesCircles = [Double]()
        circles.resultListCircles = [(Int, Int, Int)]()
        print("TIMED CONNEXTIONS ARE \(timedConnections)")
        print("RESULT LIST TIMES CIRCLES ARE \(circles.resultListTimesCircles)")
        
        let drawViewFrame = CGRect(x: 0.0, y: 130.0, width: view.bounds.width, height: view.bounds.height-130.0)
        drawingView = DrawingViewCircles(frame: drawViewFrame)
        
        print("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
                startTime2 = NSDate()
        
        //let aSelector : Selector = "update"
        
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "update:", userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        stopCircles = false
        resultsLabel.text = ""
    }
    
    
    @IBAction func StopButton(sender: AnyObject) {
        
        startButton.enabled = true
        doneButton.enabled = false
        self.navigationItem.setHidesBackButton(false, animated:true)

        let result = Results()

        
        stopCircles = true
        
        circles.checkResultList(result)
        
        resultTextCircles = ""
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            
            print("should have removed image")
        }
        
        let imageSize = CGSize(width: 1024, height: 638)
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 130), size: imageSize))
        result.displayLocal(self.view, imageView:imageView, results:self.resultsLabel)
        let image = drawCustomImage(imageSize)
        imageView.image = image
        
        // add to results
        result.name = "Circles"
        result.startTime = startTime2
        result.endTime = NSDate()
        result.screenshot = image
        resultsArray.add(result)
        
    }
    
    func drawCustomImage(size: CGSize) -> UIImage {
        print(timedConnections)
        
        // Setup our context
        //let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        drawingView.drawResultBackground()
        
        if (timedConnections.count > 0){
            
            for var k = 0; k < timedConnections.count; ++k {
                
                let (a, b, x, y, z) = timedConnections[k]
                
                print("a = \(a) b = \(b) x = \(x) y = \(y) z = \(z)")
                
                CGContextSetStrokeColorWithColor(context, getColor(z, alpha:0.7))
                
                CGContextBeginPath(context)
                CGContextSetLineWidth(context, 7.0)
                
                CGContextMoveToPoint(context, CGFloat(a), CGFloat(b))
                CGContextAddLineToPoint(context, CGFloat(x), CGFloat(y))
                
                CGContextStrokePath(context)
                
                if k == 0 {
                    let aFont = UIFont(name: "Helvetica", size: 19)
                    let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
                    let text = CFAttributedStringCreate(nil, "START", attr)
                    let line = CTLineCreateWithAttributedString(text)
                    CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
                    CGContextSetTextPosition(context, CGFloat(a-28), CGFloat(b+41))
                    CTLineDraw(line, context!)
                }
                
                if k == timedConnections.count-1 {
                    let aFont = UIFont(name: "Helvetica", size: 19)
                    let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.blackColor()]
                    let text = CFAttributedStringCreate(nil, "END", attr)
                    let line = CTLineCreateWithAttributedString(text)
                    CGContextSetTextMatrix(context, CGAffineTransformMake(CGFloat(1), CGFloat(0), CGFloat(0), CGFloat(-1),CGFloat(0), CGFloat(0)))
                    CGContextSetTextPosition(context, CGFloat(x-19), CGFloat(y+41))
                    CTLineDraw(line, context!)
                }
                
                if k > 0 {
                    
                    print("getting here")
                    
                    let (a2, b2, x2, _, z2) = timedConnections[k-1]
                    
                    CGContextSetFillColorWithColor(context, getColor(z2, alpha:0.5))
                    
                    CGContextBeginPath(context)
                    CGContextSetLineWidth(context, 7.0)
                    
                    CGContextMoveToPoint(context, CGFloat(a2), CGFloat(b2))
                    
                    let r = CGRect(x: a2-10, y: b2-10, width: 20, height: 20)
                    CGContextFillEllipseInRect(context, r)
                    
                    CGContextFillPath(context)
                    
                }
            }
            
            let (a3, b3, x3, y3, z3) = timedConnections[timedConnections.count-1]
            let r3 = CGRect(x: a3-10, y: b3-10, width: 20, height: 20)
            CGContextSetFillColorWithColor(context, getColor(z3, alpha:0.5))
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, CGFloat(a3), CGFloat(b3))
            CGContextFillEllipseInRect(context, r3)
            
            let r4 = CGRect(x: x3-10, y: y3-10, width: 20, height: 20)
            CGContextMoveToPoint(context, CGFloat(x3), CGFloat(y3))
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
        
        self.navigationItem.title = "OTA Cancellation"
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    */
    func update(timer: NSTimer) {
        
        if stopCircles == false{
            let currTime = NSDate.timeIntervalSinceReferenceDate()
            var diff: NSTimeInterval = currTime - startTime
            
            timePassedCircles = diff
            print(timePassedCircles)
            
            let minutes = UInt8(diff / 60.0)
            
            diff -= (NSTimeInterval(minutes)*60.0)
            
            let seconds = UInt8(diff)
            
            diff = NSTimeInterval(seconds)
            
            let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
            let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
            
            timerLabel.text = "\(strMinutes) : \(strSeconds)"
        }
        else{
            timer.invalidate()
        }
        
    }
    
    
    
}
