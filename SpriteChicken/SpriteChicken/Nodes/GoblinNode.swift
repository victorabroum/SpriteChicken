//
//  GoblinNode.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class GoblinNode: SKNode {
    
    public var sprite: SKSpriteNode
    public var stateMachine: GKStateMachine
    
    override init() {
        sprite = .init(imageNamed: "goblin_idle1")
        stateMachine = .init(states: [])
        super.init()
        
        // default setup
        sprite.texture?.filteringMode = .nearest
        stateMachine = .init(states: [
            GoblinAnimationsStates.Idle(self),
            GoblinAnimationsStates.Walk(self),
            GoblinAnimationsStates.Hurt(self),
        ])
        stateMachine.enter(GoblinAnimationsStates.Idle.self)
        
        // Physics Setup
        let body = SKPhysicsBody(rectangleOf: sprite.size)
        body.affectedByGravity = true
        body.allowsRotation = false
        
        body.categoryBitMask = .enemy
        body.contactTestBitMask = ~(.contactWithAllCategories()) // Contact with noone
        body.collisionBitMask = .contactWithAllCategories() // Collision with everyone
        
        self.physicsBody = body
        
        // Add child nodes
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
