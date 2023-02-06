//
//  GameOverScene.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 06/02/23.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1)
        if let gameOverScene = GameScene(fileNamed: "GameScene.sks") {
            NotificationCenter.default.post(name: .init("showUI"), object: nil)
            self.view?.presentScene(gameOverScene, transition: transition)
        }
    }
    
}
