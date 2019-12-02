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

class PrimaryController : UIViewController {
    
    private let serverURL = URL(string: "http://142.93.44.236:3000")!
    private var id : String?
    
    override func viewDidLoad() {
        print("Loaded Primary Controller")
        id = UserDefaults.standard.string(forKey: "id")
        if id == nil { getIdentifier() }
        
    }
    
    private func getIdentifier() {
        let url = serverURL.appendingPathComponent("/getIdentifier")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            self.id = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(self.id, forKey: "id")
        }

        task.resume()
    }
}
