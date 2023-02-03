//
//  GroundNode.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit

class GroundNode: SKNode {
    
    init(texture: SKTexture, position: CGPoint) {
        super.init()
        
        self.position = position
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.linearDamping = 60.0
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.isDynamic = false
        physicsBody?.friction = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
