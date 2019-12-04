//
//  PlayerData+CoreDataProperties.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 02/12/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//
//

import Foundation
import CoreData


extension PlayerData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerData> {
        return NSFetchRequest<PlayerData>(entityName: "PlayerData")
    }

    @NSManaged public var highscore: Int32
    @NSManaged public var id: UUID?

}
