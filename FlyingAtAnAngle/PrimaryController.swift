//
//  PrimaryController.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 15/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import CoreData

class PrimaryController : UIViewController {
    
    private let serverURL = URL(string: "http://142.93.44.236:3000")!
    private var id : String?
    
    override func viewDidLoad() {
        print("Loaded Primary Controller")
        
        if !loadIdentifier() {
            getIdentifier()
        }
    }
    
    private func loadIdentifier() -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PlayerData>(entityName: "PlayerData")
        
        do {
            let data = try context.fetch(fetchRequest)
            id = data[0].id
            print("ID Loaded")
        } catch {
            print("Failed to fetch data. \(error)")
            return false
        }
        
        return true
    }
    
    private func getIdentifier() {
        let url = serverURL.appendingPathComponent("/getIdentifier")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            self.id = String(data: data, encoding: .utf8)
            
            
            DispatchQueue.main.async {
            
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let player = PlayerData(context: context)
                player.id = self.id
                context.insert(player)
                
                do {
                    try context.save()
                    print("ID saved")
                } catch {
                    print("Failed to save context. \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }
}
