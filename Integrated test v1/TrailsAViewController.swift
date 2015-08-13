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

class TrailsAViewController: ViewController {
    
    var drawingView: DrawingViewTrails!
    
    var imageView: UIImageView!
    
    var startTime = NSTimeInterval()
    var startTime2 = NSDate()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func StartButton(sender: AnyObject) {
        
        if drawingView !== nil {
            drawingView.removeFromSuperview()
        }
        
        if imageView !== nil {
            
            imageView.removeFromSuperview()
            imageView.image = nil
            timedConnectionsA = [Double]()
            
        }
        
        let drawViewFrame = CGRect(x: 0.0, y: 150.0, width: view.bounds.width, height: view.bounds.height-150)
        drawingView = DrawingViewTrails(frame: drawViewFrame)
        
        println("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
        var timer = NSTimer()
        startTime2 = NSDate()
        
        let aSelector : Selector = "update"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timedConnectionsA = [Double]()
        stopTrailsA = false
        displayImgTrailsA = false
        
    }
    
    @IBAction func StopButton(sender: AnyObject) {
        stopTrailsA = true
        displayImgTrailsA = true        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        
        if stopTrailsA == false{
            var currTime = NSDate.timeIntervalSinceReferenceDate()
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
        
        if displayImgTrailsA == true {
            println("should have removed image")
            println("timed connextions = \(timedConnectionsA)")
            let imageSize = CGSize(width: 1024, height: 618)
            imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 150), size: imageSize))
            self.view.addSubview(imageView)
            let image = drawCustomImage(imageSize)
            imageView.image = image
           
            // add to results
            let result = Results()
            result.name = "Trails A"
            result.startTime = startTime2
            result.endTime = NSDate()
            result.screenshot = image
            resultsArray.addObject(result)

            displayImgTrailsA = false
        }
        
    }
    
    func drawCustomImage(size: CGSize) -> UIImage {
        println(timedConnectionsA)
        println("# connections = \(timedConnectionsA.count)")
        
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        
        if (timedConnectionsA.count > 0){
            
            for var k = 1; k < timedConnectionsA.count-1; ++k {
                
                let (a, b, fillerA) = drawingView.bubbles.bubblelist[k-1]
                let (x, y, fillerB) = drawingView.bubbles.bubblelist[k]
                
                let z = timedConnectionsA[k] - timedConnectionsA[k-1]
                
                println("a = \(a) b = \(b) x = \(x) y = \(y) z = \(z)")
                
                CGContextSetStrokeColorWithColor(context, getColor(z))
                
                CGContextBeginPath(context)
                CGContextSetLineWidth(context, 7.0)
                
                CGContextMoveToPoint(context, CGFloat(a), CGFloat(b))
                CGContextAddLineToPoint(context, CGFloat(x), CGFloat(y))
                
                CGContextStrokePath(context)
                
                if k > 1 {
                    
                    println("getting here")
                    
                    let (a2, b2, fillerA2) = drawingView.bubbles.bubblelist[k-2]
                    let (x2, y2, fillerB2) = drawingView.bubbles.bubblelist[k-1]
                    
                    let z2 = timedConnectionsA[k-1]-timedConnectionsA[k-2]
                    
                    CGContextSetFillColorWithColor(context, getColor(z2))
                    
                    CGContextBeginPath(context)
                    CGContextSetLineWidth(context, 7.0)
                    
                    CGContextMoveToPoint(context, CGFloat(a2), CGFloat(b2))
                    
                    let r = CGRect(x: a2-10, y: b2-10, width: 20, height: 20)
                    CGContextFillEllipseInRect(context, r)
                    
                    CGContextFillPath(context)
                    
                }

            }
            
            let (a3, b3, fillerA3) = drawingView.bubbles.bubblelist[timedConnectionsA.count-3]
            let (x3, y3, fillerB) = drawingView.bubbles.bubblelist[timedConnectionsA.count-2]
            
            let z3 = timedConnectionsA[timedConnectionsA.count-1]-timedConnectionsA[timedConnectionsA.count-2]
            
            let r3 = CGRect(x: a3-10, y: b3-10, width: 20, height: 20)
            CGContextSetFillColorWithColor(context, getColor(z3))
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
    
    func getColor(i: Double) ->CGColor{
        
        if i < 10.0 {
            let i2 = CGFloat(i / 10.0)
            return UIColor(hue: i2, saturation: 1.0, brightness: 1.0, alpha: 1.0).CGColor
        } else {
            return UIColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).CGColor
        }
        
        /*
        
        if i < 2.0 {
            
            return UIColor(red: 1.0, green: (CGFloat(i)/2.0), blue: 0.0, alpha: 1.0).CGColor
            
        }
        if i < 4.0 {
            return UIColor(red: (CGFloat(i-2.0)/2.0), green: 1.0, blue: 0.0, alpha: 1.0).CGColor
        }
        if i < 6.0 {
            return UIColor(red: 0.0, green: 1.0, blue: (CGFloat(i-4.0)/2.0), alpha: 1.0).CGColor
        }
        if i < 9.0 {
            return UIColor(red: 0.0, green: (CGFloat(i-6.0)/3.0), blue: 1.0, alpha: 1.0).CGColor
        }
        return UIColor.blueColor().CGColor
      */
        
    }
    
}
