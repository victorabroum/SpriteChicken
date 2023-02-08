//
//  ProjectTileNode.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 03/02/23.
//

import Foundation
import SpriteKit

class ProjectTileNode: SKNode {
    
    var sprite: SKSpriteNode
    
    init(texture: SKTexture, position: CGPoint) {
        
        sprite = SKSpriteNode(texture: texture)
        
        super.init()
        
        self.position = position
        physicsBody = SKPhysicsBody(texture: texture,
                                    size: texture.size())
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.friction = 1
        
        physicsBody?.categoryBitMask = .projectTile
        physicsBody?.collisionBitMask = ~(.contactWithAllCategories())
        physicsBody?.contactTestBitMask = ~(.contactWithAllCategories(less: [.enemy]))
        
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addImpulse(force: CGVector) {
        self.sprite.xScale = force.dx < 0 ? -1 : 1
        self.physicsBody?.applyImpulse(force)
        
        delayToDestroy()
    }
    
    public func delayToDestroy() {
        self.run(.sequence([
            .wait(forDuration: 2),
            .run{ [weak self] in
                self?.removeFromParent()
            }
        ]))
    }
    
}

class EggProjectTile: ProjectTileNode {
    init(position: CGPoint) {
        super.init(texture: .init(imageNamed: "eggProjectTile"), position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
