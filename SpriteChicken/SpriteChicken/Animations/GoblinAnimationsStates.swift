//
//  GoblinAnimationsStates.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class GoblinAnimationsStates {
    
    class Idle: GKState {
        
        public var goblinNode: GoblinNode
        
        init(_ chickenNode: GoblinNode) {
            self.goblinNode = chickenNode
        }
        
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            if(stateClass is Idle.Type) { return false }
            return true
        }
        
        override func didEnter(from previousState: GKState?) {
            let arraySprite = Array<SKTexture>.init(withFormat: "goblin_idle%@", range: 1...4)
            goblinNode.sprite.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.1)))
        }
    }
    
    class Walk: GKState {
        public var chickenNode: GoblinNode
        
        init(_ chickenNode: GoblinNode) {
            self.chickenNode = chickenNode
        }
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            if(stateClass is Walk.Type) { return false }
            return true
        }
        
        override func didEnter(from previousState: GKState?) {
            let arraySprite = Array<SKTexture>.init(withFormat: "goblin_walk%@", range: 1...4)
            chickenNode.sprite.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.1)))
        }
    }
    
    class Hurt: GKState {
        public var chickenNode: GoblinNode
        
        init(_ chickenNode: GoblinNode) {
            self.chickenNode = chickenNode
        }
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            return false
        }
    }

}
