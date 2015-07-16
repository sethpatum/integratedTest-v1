//
//  TrailsBViewController.swift
//  Integrated test v1
//
//  Created by Seth Amarasinghe on 7/14/15.
//  Copyright (c) 2015 sunspot. All rights reserved.
//
import UIKit

var stopTrailsB:Bool = false
class TrailsBViewController: UIViewController {
    
    var drawingView: DrawingViewTrailsB!
    var startTime = NSTimeInterval()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func StartButton(sender: AnyObject) {
        
        if drawingView !== nil {
            drawingView.removeFromSuperview()
        }
        let drawViewFrame = CGRect(x: 0.0, y: 150.0, width: view.bounds.width, height: view.bounds.height-150)
        
        drawingView = DrawingViewTrailsB(frame: drawViewFrame)
        
        println("\(view.bounds.width) \(view.bounds.height)")
        
        view.addSubview(drawingView)
        
        drawingView.reset()
        
        var timer = NSTimer()
        
        let aSelector : Selector = "update"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        stopTrailsB = false
        
        
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
        
        if stopTrailsB == false{
            var currTime = NSDate.timeIntervalSinceReferenceDate()
            var diff: NSTimeInterval = currTime - startTime
            let minutes = UInt8(diff / 60.0)
            
            diff -= (NSTimeInterval(minutes)*60.0)
            
            let seconds = UInt8(diff)
            
            diff = NSTimeInterval(seconds)
            
            let strMinutes = minutes > 9 ? String(minutes):"0"+String(minutes)
            let strSeconds = seconds > 9 ? String(seconds):"0"+String(seconds)
            
            timerLabel.text = "\(strMinutes) : \(strSeconds)"
        }
        
    }
    
    
}