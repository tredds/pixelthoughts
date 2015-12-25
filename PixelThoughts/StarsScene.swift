//
//  StarsScene.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 12/15/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import Foundation
import SpriteKit

class StarsScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        setupScene()
        setupCircle()
        super.didMoveToView(view)
    }
    
    func setupScene(){
        
        self.scaleMode = .AspectFill
        self.backgroundColor = SKColor(colorLiteralRed: 27/255.0, green: 39/255.0, blue: 53/255.0, alpha: 1)
        
        let starFieldNode = SKNode()
        starFieldNode.name = "test"
        starFieldNode.addChild(startEmitter(speed: 18, lifetime: self.frame.size.height, scale: 0.2, birthRate: 4, color: SKColor.whiteColor()))
        starFieldNode.addChild(startEmitter(speed: 28, lifetime: self.frame.size.height , scale: 0.4, birthRate: 2, color: SKColor.whiteColor()))
        starFieldNode.addChild(startEmitter(speed: 48, lifetime: self.frame.size.height , scale: 0.8, birthRate: 1, color: SKColor.whiteColor()))
        
        let action = SKAction.playSoundFileNamed("sound.m4a", waitForCompletion: true)
        self.runAction(SKAction.repeatActionForever(action))
        self.addChild(starFieldNode)
    }
    
    func startEmitter(speed speed: CGFloat, lifetime: CGFloat, scale: CGFloat, birthRate: CGFloat, color: SKColor) -> SKEmitterNode
    {
        let star = SKLabelNode(fontNamed: "Helvetiva")
        star.fontSize = 80.0
        star.text = "•"
        
        let textureView = SKView()
        let texture = textureView.textureFromNode(star)
        texture?.filteringMode = .Nearest
        
        let frame = self.frame
        
        let emitterNode = SKEmitterNode()
        emitterNode.particleTexture = texture
        emitterNode.particleBirthRate = birthRate
        emitterNode.particleColor = color
        emitterNode.particleLifetime = lifetime
        emitterNode.particleSpeed = speed
        emitterNode.particleSpeedRange = 20
        emitterNode.particleScale = scale
        emitterNode.particleColorBlendFactor = 1
        emitterNode.particlePositionRange = CGVectorMake(CGRectGetMaxX(frame), 0)
        emitterNode.advanceSimulationTime(NSTimeInterval(lifetime))
        emitterNode.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMinY(frame))
        return emitterNode
    }
    
    func setupCircle(){
        let circle = SKShapeNode(circleOfRadius: 300)
        circle.position = CGPointMake(frame.midX, frame.midY)
        circle.strokeColor = SKColor.orangeColor()
        circle.glowWidth = 10.0
        circle.fillColor = SKColor.whiteColor()
        self.addChild(circle)
        
        let label = SKLabelNode(fontNamed: "Helvetica-Bold")
        label.text = "Work and something else and much more to come"
        label.fontColor = UIColor.blackColor()
        circle.addChild(label)
        label.fontSize = 40
        
        let actionResize = SKAction.scaleTo(0, duration: 60)
        circle.runAction(actionResize)
    }
}