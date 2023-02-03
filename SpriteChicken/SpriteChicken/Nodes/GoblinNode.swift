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
    
    private var direction: CGFloat = 1
    private var moveSpeed: CGFloat = 0.8
    
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
        stateMachine.enter(GoblinAnimationsStates.Walk.self)
        
        // Physics Setup
        let body = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
        body.affectedByGravity = true
        body.allowsRotation = false
        
        body.categoryBitMask = .enemy
        body.contactTestBitMask = ~(.contactWithAllCategories(less:[.wall])) // Contact with noone
        body.collisionBitMask = .contactWithAllCategories(less:[.wall, .projectTile, .endPoint]) // Collision with everyone
        
        self.physicsBody = body
        
        // Add child nodes
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeDirection() {
        direction = direction == -1 ? 1 : -1
    }
    
    public func update() {
        updateMovement()
    }
    
    private func updateMovement() {
        self.sprite.xScale = direction
        self.run(.move(by: .init(dx: moveSpeed * direction, dy: 0), duration: 0.2))
    }
    
}
