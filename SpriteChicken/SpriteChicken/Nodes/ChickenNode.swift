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
    
    private var moveSpeed: CGFloat = 5
    
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
        self.physicsBody = body
        
        // Add child nodes
        self.addChild(sprite)
    }
    
    public func move(direction: CGFloat) {
        if let physicsBody {
            physicsBody.applyForce(.init(dx: direction * speed, dy: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
