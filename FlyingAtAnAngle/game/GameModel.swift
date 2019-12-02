//
//  GameModel.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 06/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import CoreMotion

class GameModel {
    private let serverURL = URL(string: "http://142.93.44.236:3000")!

    var score = 0
    var highscore = 0
    var velocity : Float = 0.0
    var acceleration : Float = 0
    var gravity : Float = -10.0
    var speedScale : Float = 1
    
    init() {
        highscore = UserDefaults.standard.integer(forKey: "highscore")
    }
    
    func gameOver() {
        if score > highscore {
            highscore = score
            UserDefaults.standard.set(highscore, forKey: "highscore")
            pushScoreToServer(score: score)
        }
    }
    
    private func pushScoreToServer(score : Int) {
        let id = UserDefaults.standard.string(forKey: "id")
        if id == nil { return }
        let url = serverURL.appendingPathComponent("/sendScore/\(score)/user/" + id!)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
}
