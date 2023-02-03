//
//  WallNode.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 03/02/23.
//

import Foundation
import SpriteKit

class WallNode: SKNode {
    
    init(texture: SKTexture, position: CGPoint) {
        super.init()
        
        self.position = position
        physicsBody = SKPhysicsBody(texture: texture,
                                    size: texture.size())
        physicsBody?.linearDamping = 60.0
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.isDynamic = false
        physicsBody?.friction = 1
        
        physicsBody?.categoryBitMask = .wall
        physicsBody?.collisionBitMask = .contactWithAllCategories()
        physicsBody?.contactTestBitMask = ~(.contactWithAllCategories())
        
        addDebugging(size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addDebugging(size: CGSize) {
        #if DEBUG
        let sprite = SKSpriteNode(color: .gray, size: size)
        sprite.alpha = 0.5
        sprite.zPosition = 5
        self.addChild(sprite)
        #endif
    }
    
}
