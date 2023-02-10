//
//  PlayerEntity.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 10/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerEntity: GKEntity {
    
    init(scene: GameScene) {
        super.init()
        
        let chickenNode = ChickenNode()
        self.addComponent(GKSKNodeComponent(node: chickenNode))
        
        if let camera = scene.camera {
            self.addComponent(CameraFollowComponent(camera: camera))
        }
                
        let stateMachine: GKStateMachine = .init(states: [
            ChickenAnimationsStates.Idle(chickenNode),
            ChickenAnimationsStates.Walk(chickenNode),
            ChickenAnimationsStates.Jump(chickenNode),
            ChickenAnimationsStates.Hurt(chickenNode),
            ChickenAnimationsStates.Shoot(chickenNode),
        ])
        stateMachine.enter(ChickenAnimationsStates.Idle.self)
        self.addComponent(StateMachineComponent(stateMachine: stateMachine))

        self.addComponent(MoveComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.component(ofType: GKSKNodeComponent.self)?.node.removeFromParent()
    }
}
