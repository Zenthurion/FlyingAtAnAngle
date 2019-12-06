//
//  GameModel.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 06/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import CoreMotion
import CoreData
import UIKit

class GameModel {
    private let serverURL = URL(string: "http://142.93.44.236:3000")!

    var score = 0
    var highscore = 0
    var velocity : Float = 0.0
    var acceleration : Float = 0
    var gravity : Float = -10.0
    var speedScale : Float = 1
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PlayerData>(entityName: "PlayerData")
        
        do {
            let data = try context.fetch(fetchRequest)
            highscore = Int(data[0].highscore)
            print("Highscore Loaded")
        } catch {
            print("Failed to load highscore \(error)")
        }
    }
    
    func gameOver() {
        if score > highscore {
            highscore = score
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<PlayerData>(entityName: "PlayerData")
            
            do {
                let data = try context.fetch(fetchRequest)
                data[0].highscore = Int32(score)
                try context.save()
                print("Highscore Saved")
                if let id = data[0].id {
                    pushScoreToServer(score: score, id: id)
                }
            } catch {
                print("Failed to save highscore \(error)")
            }
            
            
        }
    }
    
    private func pushScoreToServer(score : Int, id : String) {
        let url = serverURL.appendingPathComponent("/sendScore/\(score)/user/" + id)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
}
