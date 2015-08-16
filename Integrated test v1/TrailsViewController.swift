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
    
    
    @IBAction func HelpButton(sender: AnyObject) {
         if(selectedTest == "Trails A") {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("Trails A Help") as! UIViewController
            navigationController?.pushViewController(vc, animated:true)
        } else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("Trails B Help") as! UIViewController
            navigationController?.pushViewController(vc, animated:true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         if(selectedTest == "Trails A") {
            self.title = "Trails A"
         } else {
            self.title = "Trails B"
        }
        
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
            result.name = self.title
            result.startTime = startTime2
            result.endTime = NSDate()
            result.screenshot = image
            resultsArray.add(result)

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
    
}
