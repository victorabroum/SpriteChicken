//
//  GameViewController.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    public var playerControllerDelegate: PlayerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                playerControllerDelegate = scene
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    @IBAction func rightClick(_ sender: Any) {
        playerControllerDelegate?.tryMove(toDirection: -1)
    }
    
    @IBAction func leftButtonClicked(_ sender: Any) {
        playerControllerDelegate?.tryMove(toDirection: 1)
    }
    
    @IBAction func jumpButtonClicked(_ sender: Any) {
        playerControllerDelegate?.tryJump()
    }
    
    @IBAction func touchUp(_ sender: Any) {
        playerControllerDelegate?.tryMove(toDirection: 0)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
