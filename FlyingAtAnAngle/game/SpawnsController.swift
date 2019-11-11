//
//  SpawnsController.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 07/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class SpawnsController {
    private var scene : GameScene
    
    var coins = [CoinSprite]()
    var spawnDistance = CGFloat(300)
    var lastSpawnedHeight = CGFloat(0)
    
    init(scene : GameScene) {
        self.scene = scene
        spawnCoin()
    }
    
    func update(_ deltaTime : Float) {
        
        if scene.player != nil {
            if scene.player!.position.y > lastSpawnedHeight + spawnDistance {
                lastSpawnedHeight += spawnDistance
                spawnDistance += 1
                spawnCoin()
            }
        }
        
        for coin in coins {
            if coin.isHidden { continue }
            
            if(coin.position.y < CGFloat(scene.player!.lowest)) {
                coin.isHidden = true
            }
        }
    }
    
    func spawnCoin() {
        let spawnPosition = CGPoint(x: Double.random(in: Double(self.scene.frame.minX) ..< Double(self.scene.frame.maxX)), y: Double(scene.player!.position.y + scene.frame.height))
        var newCoin : CoinSprite?
        for coin in coins {
            if coin.isHidden {
                newCoin = coin
                break
            }
        }
        if newCoin == nil {
            newCoin = CoinSprite()
            scene.addChild(newCoin!)
            coins.append(newCoin!)
        }
        newCoin?.position = spawnPosition
        newCoin?.isHidden = false
        
        //print("Spawing Coin")
    }
}
