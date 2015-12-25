//
//  UILabel+Animation.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import UIKit
let animationDuration = 1.0

extension UILabel {
    
    func setText(text: String, animated: Bool) {
        if animated {
            let animation = CATransition()
            animation.duration = animationDuration;
            animation.type = kCATransitionFade;
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.layer.addAnimation(animation, forKey: "changeTextTransition")
            self.text = text;
        } else {
            self.layer.removeAllAnimations()
            self.text = text;
        }
    }
    
    func animate(titles titles: Array<String>, duration: Double) {
        
        let gap = duration / Double(titles.count)
        var delay = 0.0
        
        for string in titles {
            self .performSelector("changeText:", withObject: string, afterDelay: delay)
            delay += gap
        }
    }
    
    func changeText(text: String) {
        self.setText(text, animated: true)
    }
}
