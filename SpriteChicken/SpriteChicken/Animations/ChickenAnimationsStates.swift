//
//  ChickenAnimationsStates.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import GameplayKit

class ChickenAnimationsStates {
    
    class Idle: GKState {
        
        public var chickenNode: ChickenNode
        
        init(_ chickenNode: ChickenNode) {
            self.chickenNode = chickenNode
        }
        
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            if(stateClass is Idle.Type) { return false }
            return true
        }
        
        override func didEnter(from previousState: GKState?) {
            let arraySprite = Array<SKTexture>.init(withFormat: "chicken_idle%@", range: 1...4)
            chickenNode.sprite.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.1)))
        }
    }
    
    class Walk: GKState {
        public var chickenNode: ChickenNode
        
        init(_ chickenNode: ChickenNode) {
            self.chickenNode = chickenNode
        }
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            if(stateClass is Walk.Type) { return false }
            return true
        }
        
        override func didEnter(from previousState: GKState?) {
            let arraySprite = Array<SKTexture>.init(withFormat: "chicken_walk%@", range: 1...4)
            chickenNode.sprite.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.1)))
        }
    }
    
    class Jump: GKState {
        public var chickenNode: ChickenNode
        
        init(_ chickenNode: ChickenNode) {
            self.chickenNode = chickenNode
        }
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            if(stateClass is Idle.Type) { return true }
            return false
        }
    }
    
    class Hurt: GKState {
        public var chickenNode: ChickenNode
        
        init(_ chickenNode: ChickenNode) {
            self.chickenNode = chickenNode
        }
        override func isValidNextState(_ stateClass: AnyClass) -> Bool {
            return false
        }
    }
    
}
