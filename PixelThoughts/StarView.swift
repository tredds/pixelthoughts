//
//  StarView.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import UIKit

public protocol StarViewAnimation : NSObjectProtocol {
    func starViewEndedScaleAnimation();
}

class StarView : UIView {
    
    let title = UILabel()
    weak var delegate: StarViewAnimation?
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTitle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupTitle()
    }
    
    //MARK: UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height * 0.5
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        self.setup()
    }
    
    //MARK: Public
    
    func start(duration duration: Double) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.001, 0.001)
            self.title.transform = CGAffineTransformMakeScale(0.001, 0.001)
            
            }){ (finished) -> Void in
                if (self.delegate?.respondsToSelector("starViewEndedScaleAnimation") == true) {
                    self.delegate?.starViewEndedScaleAnimation()
                }
        }
    }
    
    func reload() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
            self.title.transform = CGAffineTransformIdentity
            self.title.text = " "
            }){ (finished) -> Void in
                print("finished")
        }
    }
    
    func update(text text: String, animated: Bool) {
        self.title.setText(text, animated: animated)
    }
    
    //MARK: Private
    
    private func setupTitle() {
        title.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        title.textColor = UIColor.blackColor()
        title.numberOfLines = 0
        title.text = " "
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .Center
        self.addSubview(title)
        
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: title, attribute: .CenterX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: title, attribute: .CenterY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: title, attribute: .Width, multiplier: 1, constant: 0)
        self.addConstraint(widthConstraint)
    }
    
    private func setup() {
        self.backgroundColor = UIColor.whiteColor()
        self.layer.shadowColor = UIColor.orangeColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 15.0
    }
}