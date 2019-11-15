//
//  GameParticle.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 14/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class GameParticle : GameNode {
    
    private let spinRate = CGFloat.random(in: CGFloat(0.5) ... CGFloat(3))
    private let sprite : SKSpriteNode
    var size : CGSize {
        didSet {
            sprite.size = self.size
        }
    }
    
    
    init(_ game: GameScene, useGravity: Bool = true, size: CGSize = CGSize(width: 16, height: 16)) {
        sprite = SKSpriteNode(texture: nil, color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), size: size)
        self.size = size
        super.init(game)
        self.addChild(sprite)
        //self.useGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ deltaTime: Float) {
        zRotation += CGFloat(deltaTime) * spinRate
        super.update(deltaTime)
        
        if velocity.y > 0 {
            //print("WTF?! \(acceleration), \(velocity)")
        }
    }
    
    
}
