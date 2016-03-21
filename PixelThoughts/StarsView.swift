//
//  StarsView.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import UIKit

class StarsView: UIView {

    // MARK: - Properties -
    
    var snowLayer: CAEmitterLayer? = nil
    
    // MARK: - Initialization -
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize()
    {
        self.backgroundColor = UIColor(colorLiteralRed: 27/255.0, green: 39/255.0, blue: 53/255.0, alpha: 1)
    }
    
    // MARK: - UIView Methods -
    
    override class func layerClass() -> AnyClass
    {
        return CAEmitterLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.prepare()
    }
    
    // MARK: - Private Methods -
    
    private func prepare()
    {
        
        var bigSize = 10
        var bigBirthrate: Float = 1.0
        var bigSpeed: CGFloat = 80
        
        var mediumSize = 6
        var mediumBirthrate: Float = 3.0
        var mediumSpeed: CGFloat = 24
        
        var smallSize = 2
        var smallBirthrate: Float = 20.0
        var smallSpeed: CGFloat = 18
        
        #if iOS
            bigSize = 3
            mediumSize = 2
            smallSize = 1
            
            bigBirthrate = 1
            mediumBirthrate = 2
            smallBirthrate = 6
            
            bigSpeed = 30
            mediumSpeed = 14
            smallSpeed = 9
        #endif
    
        guard let
    
            closeCell = self.star(speed: bigSpeed, lifetime: Float(self.frame.size.height) * 20, size: CGSize(width:bigSize, height:bigSize), birthRate: bigBirthrate, color: UIColor.whiteColor()),
            
            nearCell = self.star(speed: mediumSpeed, lifetime: Float(self.frame.size.height), size: CGSize(width:mediumSize, height:mediumSize), birthRate: mediumBirthrate, color: UIColor.whiteColor()),
            
            farCell = self.star(speed: smallSpeed, lifetime: Float(self.frame.size.height), size: CGSize(width:smallSize, height:smallSize), birthRate: smallBirthrate, color: UIColor.whiteColor())
            
            else {
                return
        }
        
        let snowLayer: CAEmitterLayer = self.makeEmitter()
        snowLayer.emitterCells = [closeCell, nearCell, farCell]
        self.snowLayer = snowLayer
        self.layer.addSublayer(snowLayer)
    }
    
    private func makeEmitter() -> CAEmitterLayer
    {
        let emitterLayer: CAEmitterLayer = CAEmitterLayer()
        emitterLayer.name = "starsLayer"
        emitterLayer.emitterPosition = CGPoint(x: CGRectGetMidX(frame), y: self.frame.size.height)
        emitterLayer.emitterSize = CGSizeMake(self.bounds.size.width, 2)
        emitterLayer.emitterShape = kCAEmitterLayerLine
        emitterLayer.emitterMode = kCAEmitterLayerSurface
        return emitterLayer
    }
    
    func star(speed speed: CGFloat, lifetime: Float, size: CGSize, birthRate: Float, color: UIColor) -> CAEmitterCell?
    {
        guard let image = StarsService.sharedInstance.circleImage(size, color: color) else {
            return nil
        }
        
        let emitterCell: CAEmitterCell = CAEmitterCell()
        emitterCell.name = "star"
        emitterCell.enabled = true
        emitterCell.contents = image.CGImage
        emitterCell.color = color.CGColor
        emitterCell.lifetime = lifetime
        emitterCell.birthRate = birthRate
        emitterCell.velocity = speed
        return emitterCell
    }
}
