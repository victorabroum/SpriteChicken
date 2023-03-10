//
//  PhysicsMask.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit

extension UInt32 {
    static let base: UInt32 = 0b1
    static let player = UInt32.base << 0
    static let enemy = UInt32.base << 1
    static let items = UInt32.base << 2
    static let ground = UInt32.base << 3
    static let wall = UInt32.base << 4
    static let projectTile = UInt32.base << 5
    static let trigger = UInt32.base << 6
    static let endPoint = UInt32.base << 7
    
    static let allMasks: [UInt32] = [
        .player,
        .enemy,
        .items,
        .ground,
        .wall,
        .projectTile,
        .trigger,
        .endPoint
    ]
    
    static func contactWithAllCategories(less: [UInt32] = []) -> UInt32 {
        var result: UInt32 = 0b00
        
        for category in UInt32.allMasks {
            if !less.contains(category) {
                result |= category
            }
        }
        
        return result
    }
}
