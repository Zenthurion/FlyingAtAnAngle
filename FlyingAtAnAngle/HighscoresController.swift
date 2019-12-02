//
//  HighscoresController.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 15/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import UIKit

class HighscoresController : UITableViewController {
   
    
    private let serverURL = URL(string: "http://142.93.44.236:3000")!
    var highscores = [Highscore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Highscores"
        
        tableView.register(HighscoreTableViewCell.self, forCellReuseIdentifier: "hs")
        
        getHighscoresFromServer()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath) + 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highscore = highscores[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "hs", for: indexPath) as! HighscoreTableViewCell
        cell.nameLabel.text = highscore.name
        cell.scoreLabel.text = String(highscore.score)
        return cell
    }
    
    private func getHighscoresFromServer() {
        let url = serverURL.appendingPathComponent("/getHighscores")

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            let json = try? JSONSerialization.jsonObject(with: data)
            
            if json == nil { return }
            
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                if self.highscores.count > 0 { self.highscores.removeAll() }
                
                if let dictionary = json as? [[String : Any]] {
                        for item in dictionary  {
                            self.highscores.append(Highscore(name: item["name"] as! String, score: item["score"] as! Int, id: item["id"] as! String))
                            self.tableView.insertRows(at: [IndexPath.init(row:self.highscores.count - 1, section: 0)], with: .automatic)

                    }
                }
                print("Loaded \(self.highscores.count) scores")
                
                self.tableView.endUpdates()
            }
        }
        task.resume()
    }
}
