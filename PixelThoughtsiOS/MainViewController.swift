//
//  ViewController.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 12/14/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class MainViewController: UIViewController, StarViewAnimation, UITextFieldDelegate {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var message: UILabel!
//    @IBOutlet weak var button: UIButton!
    let duration = 60.0
    
    let stars = StarsView()
    
    lazy var star : StarView = {
        let star = StarView()
        star.delegate = self
        return star
    }()
    
    var player : AVAudioPlayer?
    var mainMessage = "Put a stressful thought in the star"
    var endingMessage = "Hope you feel a little less stressed and a little more connected"
    var messages = DataProvider.sharedInstance().messegesProvider.messages()
    
    // MARK: Constrains
    var starYCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stars)
        self.view.addSubview(star)
        self.view.sendSubviewToBack(stars)
        self.setupConstraints()
//        textfield.text = "Some thought"
        
        let player : AVAudioPlayer
        
        do {
            let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sound", ofType: "m4a")!)
            try player = AVAudioPlayer(contentsOfURL: url, fileTypeHint:"m4a")
            player.numberOfLoops = -1
            player.play()
            self.player = player
        } catch {
            print("error")
        }
    }
    
    //MARK: StarViewAnimation
    
    func starViewEndedScaleAnimation()
    {
        self.setupEndingScene()
    }
    
//    @IBAction func start(sender: AnyObject) {
//        if let text = self.textfield.text {
//            self.startAnimating(text)
//        }
//    }
    //MARK: Private
    
    func startAnimating(text: String) {
        self.star.update(text: text, animated: true)
        self.setupMovingScene()
    }
    
    func setupMovingScene() {
        self.star.start(duration: duration)
        self.message.animate(titles: messages, duration: duration)
//        self.button.hidden = true
    }
    
    func setupEndingScene() {
//        self.button.hidden = false
        self.message.text = self.endingMessage
        self.star.reload()
    }
    
    func setupConstraints() {
        stars.translatesAutoresizingMaskIntoConstraints = false
        star.translatesAutoresizingMaskIntoConstraints = false
        
        let xCenterConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterX, relatedBy: .Equal, toItem: stars, attribute: .CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterY, relatedBy: .Equal, toItem: stars, attribute: .CenterY, multiplier: 1, constant: 0)
        self.view.addConstraint(yCenterConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: self.view, attribute: .Height, relatedBy: .Equal, toItem: stars, attribute: .Height, multiplier: 1, constant: 0)
        self.view.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: self.view, attribute: .Width, relatedBy: .Equal, toItem: stars, attribute: .Width, multiplier: 1, constant: 0)
        self.view.addConstraint(widthConstraint)
        
        let starXCenterConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterX, relatedBy: .Equal, toItem: star, attribute: .CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(starXCenterConstraint)
        
        self.starYCenterConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterY, relatedBy: .Equal, toItem: star, attribute: .CenterY, multiplier: 1, constant: 0)
        self.view.addConstraint(self.starYCenterConstraint)
        
        let starWidthConstraint = NSLayoutConstraint(item: star, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.5, constant: 0)
        
        let starHeightConstraint = NSLayoutConstraint(item: star, attribute: .Height, relatedBy: .Equal, toItem: star, attribute: .Width, multiplier: 1, constant: 0)
        self.view.addConstraint(starHeightConstraint)
        
        
        self.view.addConstraint(starWidthConstraint)
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Move all up
        self.starYCenterConstraint.constant = 100
        self.textFieldBottomConstraint.constant = 275
        
        UIView.animateWithDuration(0.35) { () -> Void in
            // Move Up
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Move all down
        self.starYCenterConstraint.constant = 0
        self.textFieldBottomConstraint.constant = 65
        UIView.animateWithDuration(0.35) { () -> Void in
            // Move down
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            self.startAnimating(text)
        }
        
        return true
    }
    
}



