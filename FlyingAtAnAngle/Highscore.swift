//
//  Highscore.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 01/12/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation

struct Highscore : CustomStringConvertible {
    var name : String
    var score : Int
    var id : String
    
    public var description: String { return "\(name): Score = \(score) - ID = \(id)" }
    
    init(name: String, score: Int, id: String) {
        self.name = name
        self.score = score
        self.id = id
    }
}
