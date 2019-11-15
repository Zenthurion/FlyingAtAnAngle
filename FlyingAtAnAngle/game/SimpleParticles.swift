//
//  SimpleParticles.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 14/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

class SimpleParticles {
    private var game : GameScene
    
    private var particleSpread : CGFloat = 1.0
    private var particleFrequency : Float = 0.1
    private var timeSinceSpawn : Float = 0
    
    private var particles = [GameParticle]()
    
    init(_ game : GameScene) {
        self.game = game
    }
    
    func update(_ deltaTime : Float) {
        if(timeSinceSpawn >= particleFrequency) {
            timeSinceSpawn = 0
            spawnParticle()
        }
        
        for particle in particles {
            if particle.isHidden { continue }
            if particle.position.y < game.player!.lowest - particle.size.height {
                particle.isHidden = true
                continue
            }
            
            particle.update(deltaTime)
        }
        
        timeSinceSpawn += deltaTime
    }
    
    func reset() {
        for particle in particles {
            particle.isHidden = true
        }
        timeSinceSpawn = 0
    }
    
    private func getAvailableParticle() -> GameParticle
    {
        for particle in particles {
            if particle.isHidden {
                particle.reset()
                return particle
            }
        }
        
        return createParticle()
    }
    
    private func spawnParticle() {
        let particle = getAvailableParticle()
        particle.position = game.player!.position + CGPoint(x: CGFloat.random(in: -particleSpread ..< particleSpread) * CGFloat(25), y: -35)
        particle.isHidden = false
        particle.velocity.y = game.player!.velocity.y * CGFloat(0.5)
        particle.acceleration.y = game.player!.acceleration.y - 4
        particle.setScale(CGFloat.random(in: CGFloat(0.7) ..< CGFloat(1.2)))
    }
    
    private func createParticle() -> GameParticle
    {
        let particle = GameParticle(game)
        particles.append(particle)
        game.addChild(particle)
        return particle
    }
}
