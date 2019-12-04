//
//  GameScene.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 31/10/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

class GameScene: SKScene {
    
    var gameViewController : GameViewController?
    
    var motion = CMMotionManager()
    var model = GameModel()
    
    var player : Player?
    var spawns : SpawnsController?
    var coinSound : AVAudioPlayer?
    
    var score : SKLabelNode?
    var highscore : SKLabelNode?
    
    var state = GameState.running
    
    private var lastFrameTime : Float = 0.0
    private var lastCameraPosition = CGPoint(x:0, y:0)
    private var cameraTarget = CGPoint()
    
    override func didMove(to view: SKView) {
        startDeviceMotion()
        setupGame()
    }
    
    private func setupGame() {
        player = Player(self)
        addChild(player!)
        spawns = SpawnsController(scene: self)
        
        let cameraNode = SKCameraNode()
        addChild(cameraNode)
        self.camera = cameraNode
        
        score = SKLabelNode (text: "0")
        score!.fontColor = SKColor.white
        score!.fontSize = 65
        score!.position = CGPoint(x: 0, y: frame.maxY - 140)
        camera!.addChild(score!)
        
        highscore = SKLabelNode (text: "\(model.highscore)")
        highscore!.fontColor = SKColor.white
        highscore!.fontSize = 24
        highscore!.position = CGPoint(x: 0, y: frame.maxY - 60)
        camera!.addChild(highscore!)
        
        // Based on https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
        guard let url = Bundle.main.url(forResource: "coin-pickup", withExtension: "wav") else { print("Failed"); return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            coinSound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func getDeltaTime(_ currentTime: TimeInterval) -> Float {
        return Float(currentTime) - lastFrameTime
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastFrameTime == 0 { lastFrameTime = Float(currentTime); return }
        let deltaTime = getDeltaTime(currentTime)
        
        switch state {
        case .running:
            spawns?.update(deltaTime)
            player?.update(deltaTime)
        default:
            break
        }
        
        updateCameraPosition()
        
        lastFrameTime = Float(currentTime)
    }
    
    private func updateCameraPosition() {
        if camera != nil, player != nil {
            cameraTarget.y = lerp(cameraTarget.y, player!.position.y, CGFloat(0.12))
            if cameraTarget.y > player!.lowest {
                camera!.position.y = cameraTarget.y + 100
            }
        }
    }
    
    // Based on example from official documentation
    // developer.apple.com/documentation/coremotion/getting_processed_device-motion_data
    private func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.showsDeviceMovementDisplay = true
            motion.startDeviceMotionUpdates(using: .xArbitraryZVertical)
        }
    }
    
    func gameOver() {
        state = .gameOver
        
        model.gameOver()
        gameViewController?.showButtons()
    }
    
    func restart() {
        player?.reset()
        spawns?.reset()
        
        model.score = 0
        score?.text = "0"
        highscore?.text = "\(model.highscore)"
        
        state = .running
        
        gameViewController?.hideButtons()
    }
    
    func playCoinSound() {
        guard let coinSound = coinSound else { return }
        
        coinSound.play()
    }
    
    func lerp(_ a: CGFloat, _ b: CGFloat, _ t: CGFloat) -> CGFloat {
        return (1 - t) * a + t * b
    }
}
