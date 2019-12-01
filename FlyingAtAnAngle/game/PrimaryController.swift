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

class PrimaryController : UIViewController /*, GKGameCenterControllerDelegate */{
    
    //var gcEnabled = Bool()
    //var gcDefaultLeaderBoard = String()
         
    
    //let LEADERBOARD_ID = "dk.sdu.mmmi.mamja18.flyingatanangle"
    
//    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
//
//
//        authenticatePlayer()
//
//    }
//
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
            //print("ID: " + String(data: data, encoding: .utf8)!)
            self.id = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(self.id, forKey: "id")
        }

        task.resume()
    }

    
//    private func authenticatePlayer() {
//        let player = GKLocalPlayer()
//        player.authenticateHandler = {(viewController : UIViewController?, error : Error?) -> Void in
//            print("Authenticated?: \(player.playerID)")
//
//        }
//
//        player.authenticateHandler = {(viewController, error : Error?) -> Void in
//            if((viewController) != nil) {
//                // 1. Show login if player is not logged in
//                self.present(viewController!, animated: true, completion: nil)
//            } else if (player.isAuthenticated) {
//                // 2. Player is already authenticated & logged in, load game center
//                self.gcEnabled = true
//
//                // Get the default leaderboard ID
//                player.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error : Error?) in
//                    if error != nil { print(error)
//                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
//                })
//
//            } else {
//                // 3. Game center is not enabled on the users device
//                self.gcEnabled = false
//                print("Local player could not be authenticated!")
//                print(error)
//            }
//        }
//    }
//
//
//    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
//    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
//         if (viewController != nil)
//         {
//             //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
//             [self showAuthenticationDialogWhenReasonable: viewController];
//         }
//         else if (localPlayer.isAuthenticated)
//         {
//             //authenticatedPlayer: is an example method name. Create your own method that is called after the local player is authenticated.
//             [self authenticatedPlayer: localPlayer];
//         }
//         else
//         {
//             [self disableGameCenter];
//         }
//     };
}
