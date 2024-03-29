//
//  Player.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 07/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class Player : GameNode {
    private var timer : Timer?
    
    var highest = CGFloat(0)
    var lowest : CGFloat {
        get {
            return highest - CGFloat(1000)
        }
    }
    
    let sprite : SKSpriteNode
    var particles : SKEmitterNode?
    let trail : SimpleParticles
    
    init(_ game : GameScene) {
        
        sprite = SKSpriteNode(texture: SKTexture(imageNamed: "player"), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), size: CGSize(width: 64, height: 64))
        sprite.zRotation = CGFloat(Float.pi / 2)
        
        trail = SimpleParticles(game)
        
        super.init(game)
        
        maxVelocity = CGPoint(x: 10, y: 20)
        minVelocity = CGPoint(x: -10, y: -8)
        velocity.y = 15
        
        addChild(sprite)
        
        setAccelerometerTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setAccelerometerTimer() {
        timer = Timer(fire: Date(), interval: (1.0 / 60), repeats: true, block: {
            (timer) in if let data = self.game.motion.deviceMotion {
                self.acceleration.x = self.game.lerp(self.acceleration.x, CGFloat(data.gravity.x) * 60, 0.5)
            }
        })
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
    }

    override func update(_ deltaTime : Float) {
        super.update(deltaTime)
        velocity.x = acceleration.x
        
        //wrapAroundView() // Use this
        limitToView() // Or this, but not both
        
        checkCollisions()
        
        trail.update(deltaTime)
        
        if highest < position.y { highest = position.y }
        if position.y < lowest - sprite.size.height - 200 {
            game.gameOver()
        }
    }
    
    override func reset() {
        super.reset()
        
        trail.reset()
        highest = CGFloat(0)
        velocity.y = 15
    }
    
    private func checkCollisions() {
        if let coins = game.spawns?.coins {
            for coin in coins {
                if !coin.isHidden, coin.intersects(sprite) {
                    hitCoin(coin)
                }
            }
        }
    }
    
    private func hitCoin(_ coin : CoinSprite) {
        game.model.score += 1
        game.score?.text = "\(game.model.score)"
        coin.isHidden = true
        game.playCoinSound()
        
        if acceleration.y < 0 {
            acceleration.y = CGFloat(15)
            if(velocity.y < 0) {
                velocity.y = 0
            }
            
        } else {
            acceleration.y += CGFloat(3)
        }
    }
    
    private func wrapAroundView() {
        if(position.x + sprite.frame.width < game.frame.minX) { position.x = game.frame.maxX + sprite.frame.width}
        if(position.x - sprite.frame.width > game.frame.maxX) { position.x = game.frame.minX - sprite.frame.width }
    }
    private func limitToView() {
        if(position.x - sprite.frame.width / 2 < game.frame.minX) { position.x = game.frame.minX + sprite.frame.width / 2; velocity.x = 0 }
        if(position.x + sprite.frame.width / 2 > game.frame.maxX) { position.x = game.frame.maxX - sprite.frame.width / 2; velocity.x = 0 }
    }
}
