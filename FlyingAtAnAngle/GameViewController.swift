//
//  GameViewController.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 31/10/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    private var scene : GameScene?
    private var restartButton : UIButton?
    private var exitButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            scene = GameScene()
            scene?.gameViewController = self
                
            scene!.scaleMode = .resizeFill
            scene!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene!.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                
            view.presentScene(scene!)
            print("Scene presented...")
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            restartButton = view.viewWithTag(5) as? UIButton
            exitButton = view.viewWithTag(6) as? UIButton
            
            restartButton?.addTarget(self, action: #selector(restartClicked), for: .touchUpInside)
            exitButton?.addTarget(self, action: #selector(exitClicked), for: .touchUpInside)
            
            hideButtons()
            print("View presented...")
        }
        print("Did load...")
    }
    
    @objc private func restartClicked(_ sender: UIButton) {
        scene?.restart()
    }
    
    @objc private func exitClicked(_ sender: UIButton) {
        
    }
    
    func showButtons() {
        restartButton?.isHidden = false
        exitButton?.isHidden = false
        print("Showing buttons")
    }
    
    func hideButtons() {
        restartButton?.isHidden = true
        exitButton?.isHidden = true
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
