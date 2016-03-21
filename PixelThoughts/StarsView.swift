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
        guard let
            closeCell = self.star(speed: 80, lifetime: Float(self.frame.size.height) * 20, size: CGSize(width:10, height:10), birthRate: 1, color: UIColor.whiteColor()),
            
            nearCell = self.star(speed: 24, lifetime: Float(self.frame.size.height), size: CGSize(width:6, height:6), birthRate: 3, color: UIColor.whiteColor()),
            
            farCell = self.star(speed: 18, lifetime: Float(self.frame.size.height), size: CGSize(width:2, height:2), birthRate: 20, color: UIColor.whiteColor())
            
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
