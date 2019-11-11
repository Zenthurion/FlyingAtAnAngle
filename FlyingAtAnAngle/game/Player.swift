//
//  Player.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 07/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    private let scene : GameScene
    private var timer : Timer?
    
    private var velocity = CGPoint()
    private var acceleration = CGPoint(x: 0, y: 10)
    var position = CGPoint(x: 0, y: 0)
    
    private var maxVelocity = CGPoint(x: 10, y: 30)
    private var minVelocity = CGPoint(x: -10, y: -10)
    
    var highest = CGFloat(0)
    var lowest : CGFloat {
        get {
            return highest - CGFloat(1000)
        }
    }
    
    let sprite : SKSpriteNode

    
    init(_ scene : GameScene) {
        self.scene = scene
        
        sprite = SKSpriteNode(texture: SKTexture(imageNamed: "player"), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), size: CGSize(width: 64, height: 64))
        sprite.zRotation = CGFloat(Float.pi / 2)
        
        scene.addChild(sprite)
        
        setAccelerometerTimer()
        
    }
        
    private func setAccelerometerTimer() {
        timer = Timer(fire: Date(), interval: (1.0 / 60), repeats: true, block: {
            (timer) in if let data = self.scene.motion.deviceMotion {
                self.acceleration.x = CGFloat(data.gravity.x)
            }
        })
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
    }

    func update(_ deltaTime : Float) {
        sprite.position = position
        acceleration.y += CGFloat(scene.game.gravity * deltaTime)
        acceleration.x = acceleration.x * 60 * ((acceleration.x < 0 && velocity.x > 0) || (acceleration.x > 0 && velocity.x < 0) ? 15 : 1)
        velocity = velocity + (acceleration * CGFloat(deltaTime))
        
        velocity.x = acceleration.x
        
        clampVelocity()
        position = position + velocity
        
        //wrapAroundView()
        limitToView()
        
        print("A: \(acceleration) V: \(velocity) P: \(position)")
        checkCollisions()
        
        if(highest < position.y) { highest = position.y }
        print("Height: \(highest)")
    }
    
    private func checkCollisions() {
        if let coins = scene.spawns?.coins {
            for coin in coins {
                if !coin.isHidden, coin.intersects(sprite) {
                    hitCoin(coin)
                }
            }
        }
    }
    
    private func hitCoin(_ coin : CoinSprite) {
        scene.game.score += 1
        scene.score?.text = "\(scene.game.score)"
        coin.isHidden = true
        
        if acceleration.y < 0 { acceleration.y = CGFloat(10) }
        acceleration.y += CGFloat(5)
    }
    
    private func wrapAroundView() {
        if(position.x + sprite.frame.width < scene.frame.minX) { position.x = scene.frame.maxX + sprite.frame.width}
        if(position.x - sprite.frame.width > scene.frame.maxX) { position.x = scene.frame.minX - sprite.frame.width }
    }
    private func limitToView() {
        if(position.x - sprite.frame.width / 2 < scene.frame.minX) { position.x = scene.frame.minX + sprite.frame.width / 2; velocity.x = 0 }
        if(position.x + sprite.frame.width / 2 > scene.frame.maxX) { position.x = scene.frame.maxX - sprite.frame.width / 2; velocity.x = 0 }
    }
    
    private func clampVelocity() {
        if velocity.x > maxVelocity.x { velocity.x = maxVelocity.x }
        if velocity.x < minVelocity.x { velocity.x = minVelocity.x }
        if velocity.y > maxVelocity.y { velocity.y = maxVelocity.y }
        if velocity.y < minVelocity.y { velocity.y = minVelocity.y }
        
    }
}
