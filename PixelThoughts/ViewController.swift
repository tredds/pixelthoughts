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

class ViewController: UIViewController, ResultsControllerSelection, StarViewAnimation {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var button: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stars)
        self.view.addSubview(star)
        self.view.sendSubviewToBack(stars)
        self.setupConstraints()
        
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
    
    override weak var preferredFocusedView: UIView? {
        return nil
    }
    
    @IBAction func showSearch(sender: AnyObject) {
        let results = ResultsController()
        results.delegate = self
        let searchController = UISearchController.init(searchResultsController: results)
        
        searchController.searchResultsUpdater = results
        searchController.hidesNavigationBarDuringPresentation = false
        
        let searchPlaceholderText = NSLocalizedString("Enter keyword (e.g. work)", comment: "")
        searchController.searchBar.placeholder = searchPlaceholderText
        
        self.presentViewController(searchController, animated: true, completion: { () -> Void in
            
        })
    }
    
    //MARK: ResultsControllerSelection
    
    func resultsControllerSelectionSelect(string: String) {
        self.star.update(text: string, animated: true)
        self.setupMovingScene()
    }
    
    //MARK: StarViewAnimation
    
    func starViewEndedScaleAnimation()
    {
        self.setupEndingScene()
    }
    
    //MARK: Private 
    
    func setupMovingScene() {
        self.star.start(duration: duration)
        self.message.animate(titles: messages, duration: duration)
        self.button.hidden = true
    }
    
    func setupEndingScene() {
        self.button.hidden = false
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
        
        let starYCenterConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterY, relatedBy: .Equal, toItem: star, attribute: .CenterY, multiplier: 1, constant: 0)
        self.view.addConstraint(starYCenterConstraint)
        
        let starHeightConstraint = NSLayoutConstraint(item: star, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: 0)
        self.view.addConstraint(starHeightConstraint)
        
        let starWidthConstraint = NSLayoutConstraint(item: star, attribute: .Width, relatedBy: .Equal, toItem: star, attribute: .Height, multiplier: 1, constant: 0)
        self.view.addConstraint(starWidthConstraint)
    }
}



