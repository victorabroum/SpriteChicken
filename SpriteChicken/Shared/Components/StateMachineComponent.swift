//
//  StateMachineComponent.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 10/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class StateMachineComponent: GKComponent {
    
    var stateMachine: GKStateMachine
    
    init(stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
