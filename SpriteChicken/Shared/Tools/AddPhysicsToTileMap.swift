//
//  AddPhysicsToTileMap.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit

extension SKTileMapNode {
    
    //call this by passing in your SKTileMapNode, then you should delete the original SKTileMapNode
    func addPhysicsToTileMap()
    {
        
        let tileMap = self
        let startingLocation:CGPoint = tileMap.position
        
        let tileSize = tileMap.tileSize
        
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            
            for row in 0..<tileMap.numberOfRows {
                
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    
                    tileDefinition.textures[0].filteringMode = .nearest
                    
                    if(tileDefinition.userData?["noPhysics"] != nil) { continue }
                    
                    let tileArray = tileDefinition.textures
                    let tileTexture = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width / 2)
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height / 2)
                    
                    
                    var tileNode: SKNode!
                    
                    if(tileDefinition.userData?["wall"] != nil) {
                        tileNode = WallNode(texture: tileTexture, position: .init(x: x, y: y))
                        self.scene?.addChild(tileNode)
                    } else if (tileDefinition.userData?["endPoint"] != nil) {
                        tileNode = EndPointNode(position: .init(x: x, y: y))
                        self.scene?.addChild(tileNode)
                    } else if let named = tileDefinition.userData?["spawn"] as? String {
                        tileNode = spawnNode(named: named, at: .init(x: x, y: y))
                    }else {
                        tileNode = GroundNode(texture: tileTexture, position: .init(x: x, y: y))
                        self.addChild(tileNode)
                    }

                    tileNode.position = CGPoint(x: tileNode.position.x + startingLocation.x, y: tileNode.position.y + startingLocation.y)
                    
                }
            }
        }
    }
    
    private func spawnNode(named: String, at position: CGPoint) -> SKNode {
        
        var spawnedNode = SKNode()
        guard let gameScene = self.scene as? GameScene else { return spawnedNode }
        
        if named == "goblin" {
            spawnedNode = GoblinNode()
            spawnedNode.position = position
            gameScene.addEnemyNode(spawnedNode)
        } else if named == "player" {
            gameScene.addPlayer(at: position)
        }
        
        return spawnedNode
    }
    
}
