//
//  GameScene.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    public var playerControllerDelgate: PlayerControllerDelegate?
    
    private var chickenNode: ChickenNode?
    
    private var lastUpdateTime: TimeInterval = 0
    
    private var enemies: SKNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self
        
        if let tileMapNode = self.childNode(withName: "/tileMaps/tileMap") as? SKTileMapNode {
            tileMapNode.addPhysicsToTileMap()
        }
        
        if let triggerMapNode = self.childNode(withName: "/tileMaps/triggers") as? SKTileMapNode {
            triggerMapNode.addPhysicsToTileMap()
            triggerMapNode.removeFromParent()
        }
        
        enemies = SKNode()
        self.addChild(enemies)
    }
    
    override func didMove(to view: SKView) {
        do {
            chickenNode = ChickenNode()
            chickenNode?.position.y = 100
            self.addChild(chickenNode!)
        }
        
        do {
            let goblinNode = GoblinNode()
            goblinNode.position.x = 30
            self.enemies.addChild(goblinNode)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

//        let dt = currentTime - self.lastUpdateTime

        chickenNode?.updateMovement()
        
        if let enemies {
            for enemy in enemies.children {
                if let goblin = enemy as? GoblinNode {
                    goblin.update()
                }
            }
        }
        
        
        cameraFollow()
    }
    
    private func cameraFollow() {
        if let chickenNode {
            let positionOffset: CGPoint = .init(x: chickenNode.position.x,
                                                y: chickenNode.position.y + 25)
            camera?.run(.move(to: positionOffset, duration: 0.3))
        }
    }
    
}

protocol PlayerControllerDelegate {
    func tryJump()
    func tryMove(toDirection direction: CGFloat)
    func tryShoot()
}

extension GameScene: PlayerControllerDelegate {
    func tryJump() {
        chickenNode?.jump()
    }
    
    func tryMove(toDirection direction: CGFloat) {
        chickenNode?.move(direction: direction)
    }
    
    func tryShoot() {
        chickenNode?.shoot()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        testContactPlayerWithEnemy(bodyA: contact.bodyA, bodyB: contact.bodyB)
        testContactPlayerWithEnemy(bodyA: contact.bodyB, bodyB: contact.bodyA)
        
        testContactEnemyWithWall(bodyA: contact.bodyA, bodyB: contact.bodyB)
        testContactEnemyWithWall(bodyA: contact.bodyB, bodyB: contact.bodyA)
    }
    
    private func testContactPlayerWithEnemy(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        if (((bodyA.node as? ChickenNode) != nil) && ((bodyB.node as? GoblinNode) != nil)) {
            print("M O RR E U")
        }
    }
    
    private func testContactEnemyWithWall(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        if let enemyNode = bodyA.node as? GoblinNode, ((bodyB.node as? WallNode) != nil) {
            enemyNode.changeDirection()
        }
    }
    
}
