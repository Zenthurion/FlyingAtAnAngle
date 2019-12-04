//
//  SimpleGameObject.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 14/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class SimpleGameNode : SKNode {
    var game : GameScene
    var velocity = CGPoint(x:0, y: 0)
    var acceleration = CGPoint(x: 0, y: 13)
    var useGravity = true
    
    required init(_ game : GameScene) {
        self.game = game
        super.init()
    }
    
    // Required init for overrides of SKNode
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ deltaTime : Float) {
        if useGravity { acceleration.y += CGFloat(game.game.gravity * deltaTime) }
        velocity = velocity + acceleration
        position = position + velocity
    }
}
