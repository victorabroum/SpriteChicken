//
//  GameScene.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        if let tileMapNode = self.childNode(withName: "tileMap") as? SKTileMapNode {
            tileMapNode.addPhysicsToTileMap()
        }
        
    }
    
    override func didMove(to view: SKView) {
        do {
            let node = ChickenNode()
            node.position.y = 100
            self.addChild(node)
        }
        
        do {
            let goblinNode = GoblinNode()
            goblinNode.position.x = 30
            self.addChild(goblinNode)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
