//
//  ChickenNode.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class ChickenNode: SKNode {
    
    public var sprite: SKSpriteNode
    public var stateMachine: GKStateMachine
    
    private var moveSpeed: CGFloat = 0.9
    private var direction: CGFloat = 0
    
    override init() {
        sprite = .init(imageNamed: "chicken_idle1")
        stateMachine = .init(states: [])
        super.init()
        
        // default setup
        sprite.texture?.filteringMode = .nearest
        stateMachine = .init(states: [
            ChickenAnimationsStates.Idle(self),
            ChickenAnimationsStates.Walk(self),
            ChickenAnimationsStates.Jump(self),
            ChickenAnimationsStates.Hurt(self),
        ])
        stateMachine.enter(ChickenAnimationsStates.Idle.self)
        
        // Physics Setup
        let body = SKPhysicsBody(rectangleOf: sprite.size)
        body.affectedByGravity = true
        body.allowsRotation = false
        body.linearDamping = 1
        
        body.categoryBitMask = .player
        body.contactTestBitMask = ~(.contactWithAllCategories(less:[.enemy])) // Contact with noone
        body.collisionBitMask = .contactWithAllCategories() // Collision with everyone
        
        self.physicsBody = body
        
        // Add child nodes
        self.addChild(sprite)
    }
    
    public func move(direction: CGFloat) {
        self.direction = direction
    }
    
    public func jump() {
        if let physicsBody {
            physicsBody.applyForce(.init(dx: 0, dy: 200))
        }
    }
    
    func updateMovement() {
        if(direction == 0) {
            stateMachine.enter(ChickenAnimationsStates.Idle.self)
        } else {
            stateMachine.enter(ChickenAnimationsStates.Walk.self)
            self.sprite.xScale = direction
        }
        
        self.run(.move(by: .init(dx: direction * moveSpeed, dy: 0), duration: 0.1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
