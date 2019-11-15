//
//  SimpleGameObject.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 14/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class GameNode : SKNode {
    var game : GameScene
    var velocity = CGPoint(x:0, y: 0)
    var acceleration = CGPoint(x: 0, y: 3) // Old: 13
    var maxVelocity = CGPoint(x: 9999, y: 9999)
    var minVelocity = CGPoint(x: -9999, y: -9999)
    var useGravity = true
    var limitAccelerationToVelocityCap = true
    
    init(_ game : GameScene, useGravity: Bool = true) {
        self.game = game
        super.init()
    }
    
    // Required init for overrides of SKNode
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ deltaTime : Float) {
        if useGravity { acceleration.y += CGFloat(game.model.gravity * deltaTime) }
        if limitAccelerationToVelocityCap {
            acceleration = limitCGPoint(original: acceleration, maxLimiter: maxVelocity, minLimiter: minVelocity)
        }
        
        velocity = velocity + (acceleration * CGFloat(deltaTime))
        velocity = limitCGPoint(original: velocity, maxLimiter: maxVelocity, minLimiter: minVelocity)
        position = position + velocity
    }
    
    func reset(){
        acceleration = CGPoint(x: 0, y: 0)
        velocity = CGPoint(x: 0, y: 0)
        position = CGPoint(x: 0, y: 0)
        setScale(1)
    }
    
    private func limitCGPoint(original: CGPoint, maxLimiter: CGPoint, minLimiter: CGPoint) -> CGPoint {
        return CGPoint(x: CGFloat.maximum(CGFloat.minimum(original.x, maxLimiter.x), minLimiter.x), y: CGFloat.maximum(CGFloat.minimum(original.y, maxLimiter.y), minLimiter.y))
    }
}
