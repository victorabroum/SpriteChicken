//
//  MoveComponent.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 10/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class MoveComponent: GKComponent {
    
    var node: SKNode?
    
    var moveSpeed: CGFloat = 1
    var direction: CGFloat = 0
    
    var stateMachinComp: StateMachineComponent?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node
        stateMachinComp = self.entity?.component(ofType: StateMachineComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        node?.position.x += moveSpeed * direction
    }
    
    public func changeDirection(_ value: CGFloat) {
        if(value == 0) {
            stateMachinComp?.stateMachine.enter(ChickenAnimationsStates.Idle.self)
        } else {
            node?.xScale = value
            stateMachinComp?.stateMachine.enter(ChickenAnimationsStates.Walk.self)
        }
        self.direction = value
    }
    
}
