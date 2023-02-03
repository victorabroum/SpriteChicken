//
//  EndPointNode.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 03/02/23.
//

import Foundation
import SpriteKit

class EndPointNode: SKNode {
    
    var sprite: SKSpriteNode
    
    init(position: CGPoint) {
        sprite = SKSpriteNode(imageNamed: "eggs")
        super.init()
        
        self.addChild(sprite)
        self.position = position
        
        physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        physicsBody?.linearDamping = 60.0
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.isDynamic = false
        physicsBody?.friction = 1
        
        physicsBody?.categoryBitMask = .wall
        physicsBody?.collisionBitMask = .contactWithAllCategories(less:[.wall, .ground])
        physicsBody?.contactTestBitMask = ~(.contactWithAllCategories())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
