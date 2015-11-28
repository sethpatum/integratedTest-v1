//
//  CreditsViewController.swift
//  CNToolkit
//
//  Created by Seth Amarasinghe on 11/28/15.
//  Copyright © 2015 sunspot. All rights reserved.
//

import UIKit
import AVFoundation

class CreditsViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()

    
    
    @IBAction func JohnCena(sender: AnyObject) {
        player.play()
       
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            
            let audioPath = NSBundle.mainBundle().pathForResource("SoundEffect1", ofType: "mp3")
            var error:NSError? = nil
            do {
                player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            }
            catch {
                print("Something bad happened. Try catching specific errors to narrow things down")
            }
            
                   // Do any additional setup after loading the view.
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
