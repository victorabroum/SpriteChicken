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
    public var audioNode: SKAudioNode
    public var canJump: Bool = true
    
    private var shootForce: CGFloat = 0.1
    private var canShoot: Bool = true
    
    override init() {
        sprite = .init(imageNamed: "chicken_idle1")
        audioNode = SKAudioNode()
        super.init()
        
        // default setup
        sprite.texture?.filteringMode = .nearest
        
        
        // Physics Setup
        let body = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
        body.affectedByGravity = true
        body.allowsRotation = false
        body.mass = 0.1
        body.friction = 0.2
        body.restitution = 0
        
        body.categoryBitMask = .player
        body.contactTestBitMask = ~(.contactWithAllCategories(less:[.enemy, .endPoint, .ground])) // Contact with noone
        body.collisionBitMask = .contactWithAllCategories(less:[.wall, .projectTile, .endPoint]) // Collision with everyone
        
        self.physicsBody = body
        
        // Add child nodes
        self.addChild(sprite)
        self.addChild(audioNode)
    }
    
    public func jump() {
        guard canJump else { return }
        
        canJump = false
        
        if let physicsBody {
            physicsBody.applyImpulse(.init(dx: 0, dy: 30))
        }
        
        self.run(.group([
            .playSoundFileNamed("hop.wav", waitForCompletion: false),
            .changeVolume(to: 0.3, duration: 0.1),
        ]))
    }
    
    public func shoot() {
        
        guard canShoot else { return }
        
        canShoot = false
        
        self.run(.playSoundFileNamed("chicken_0\(Int.random(in: 1...2))", waitForCompletion: false))
        
//        stateMachine.enter(ChickenAnimationsStates.Shoot.self)
        let eggProjectTile = EggProjectTile(position: self.position)
        self.scene?.addChild(eggProjectTile)

        eggProjectTile.run(.sequence([
            .fadeAlpha(to: 0, duration: 0),
            .wait(forDuration: 0.25),
            .fadeAlpha(to: 1, duration: 0),
            .run {[weak self] in
                guard let self else { return }
                eggProjectTile.addImpulse(force: .init(dx: (self.sprite.xScale * -1) * self.shootForce, dy: 0))
            },
            .wait(forDuration: 0.2),
            .run { [weak self] in
                self?.canShoot = true
            }
        ]))
    }
    
    public func died() {
//        stateMachine.enter(ChickenAnimationsStates.Hurt.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
