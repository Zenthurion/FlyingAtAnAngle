//
//  CGPointExtensions.swift
//  FlyingAtAnAngle
//
//  Created by Markus Jakobsen on 07/11/2019.
//  Copyright © 2019 Markus Jakobsen. All rights reserved.
//

import Foundation
import SpriteKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func *(left: CGPoint, right: Int) -> CGPoint {
    return CGPoint(x: left.x * CGFloat(right), y: left.y * CGFloat(right))
}
func *(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * CGFloat(right), y: left.y * CGFloat(right))
}
func /(left: CGPoint, right: Int) -> CGPoint {
    return CGPoint(x: left.x / CGFloat(right), y: left.y / CGFloat(right))
}
