//
//  ViewController.swift
//  BullsEye
//
//  Created by Scott Lawrence on 7/2/15.
//  Copyright (c) 2015 Rabbit Hollow Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        
        var points = 100 - difference
        
        var title: String
        if difference == 0{
            title = "Perfect! Have 200 bonus points."
            points += 200
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1{
                title += " Have 50 bonus points."
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close ..."
        }
        
        score += points
        
        let msg = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
                                                                            self.startNewRound()
                                                                            self.updateLabels()})
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(){
        startNewGame()
        updateLabels()
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
}

