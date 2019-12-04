//
//  CoinSprite.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 07/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class CoinSprite : SKSpriteNode {
    init() {
        super.init(texture: nil, color: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), size: CGSize(width: 64, height: 64))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(_ deltaTime: Float) {
        zRotation += CGFloat(deltaTime)
    }
}
