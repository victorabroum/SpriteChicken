//
//  GameScene.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import AVFoundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    public var playerControllerDelgate: PlayerControllerDelegate?
    
    private var chickenNode: ChickenNode?
    
    private var lastUpdateTime: TimeInterval = 0
    
    private var enemies: SKNode!
    private var avPlayer: AVPlayer!
    
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
        
        setupAudio(musicNamed: "bg_music", extensionNamed: "mp3")
        
        NotificationCenter.default.addObserver(self, selector: #selector(gameOver), name: .init("gameOver"), object: nil)

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
    
    private func setupAudio(musicNamed: String, extensionNamed: String) {
        if let musicURL = Bundle.main.url(forResource: musicNamed, withExtension: extensionNamed) {
            avPlayer = AVPlayer(url: musicURL)
            avPlayer.volume = 0.2
            self.run(.sequence([
                .wait(forDuration: 0.2),
                .run { [weak self] in
                    self?.avPlayer.play()
                }
            ]))
        }
    }
    
    private func cameraFollow() {
        if let chickenNode {
            let positionOffset: CGPoint = .init(x: chickenNode.position.x,
                                                y: chickenNode.position.y + 25)
            camera?.run(.move(to: positionOffset, duration: 0.3))
        }
    }
    
    @objc
    private func gameOver() {
        avPlayer.pause()
        setupAudio(musicNamed: "jingle_lose", extensionNamed: "wav")
        self.run(.playSoundFileNamed("lose_sound.wav", waitForCompletion: false))
        
        
        do {
            let bg = SKSpriteNode(imageNamed: "black_bg")
            let mask = SKCropNode()
            let maskNode = SKSpriteNode(imageNamed: "mask")
            maskNode.texture?.filteringMode = .nearest
            mask.maskNode = maskNode
            mask.setScale(0)
            
            mask.position = chickenNode?.position ?? .zero
            
            mask.addChild(bg)
            self.addChild(mask)
            
            mask.run(.sequence([
                .wait(forDuration: 0.5),
                .scale(to: 6, duration: 1.3),
                // CHANGE SCENE
            ]))
            
            mask.zPosition = 999
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
        
        testContactPlayerWithEndPoint(bodyA: contact.bodyA, bodyB: contact.bodyB)
        testContactPlayerWithEndPoint(bodyA: contact.bodyB, bodyB: contact.bodyA)
        
        testContactEnemyWithProjectTile(bodyA: contact.bodyA, bodyB: contact.bodyB)
        testContactEnemyWithProjectTile(bodyA: contact.bodyB, bodyB: contact.bodyA)
    }
    
    private func testContactPlayerWithEnemy(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        if (((bodyA.node as? ChickenNode) != nil) && ((bodyB.node as? GoblinNode) != nil)) {
            chickenNode?.died()
        }
    }
    
    private func testContactEnemyWithWall(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        if let enemyNode = bodyA.node as? GoblinNode, ((bodyB.node as? WallNode) != nil) {
            enemyNode.changeDirection()
        }
    }
    
    private func testContactEnemyWithProjectTile(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        if let enemyNode = bodyA.node as? GoblinNode, ((bodyB.node as? ProjectTileNode) != nil) {
            enemyNode.died()
        }
    }
    
    private func testContactPlayerWithEndPoint(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) {
        if ((bodyA.node as? ChickenNode) != nil) && ((bodyB.node as? EndPointNode) != nil) {
            print("GANHOU MISERAVI")
            self.run(.playSoundFileNamed("level_complete.wav", waitForCompletion: false))
        }
    }
    
}
