//
//  GameViewController.swift
//  SpriteChicken-TvOS
//
//  Created by Victor Vasconcelos on 08/02/23.
//

import UIKit
import SpriteKit
import GameplayKit
import GameController


class GameViewController: UIViewController {
    
    var gameContorller: GCController?
    public var playerControllerDelegate: PlayerControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotificationHandlerGameController()
        
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
            #if DEBUG
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
            #endif
        }
    }
    
    private func setupNotificationHandlerGameController() {
        NotificationCenter.default.addObserver(self, selector: #selector(controllerDidConnect), name: .init(NSNotification.Name.GCControllerDidConnect), object: nil)
    }

    @objc private func controllerDidConnect() {
        if !GCController.controllers().isEmpty &&
            GCController.controllers()[0].extendedGamepad != nil {
            gameContorller = GCController.controllers()[0]
            gameContorller?.extendedGamepad?.valueChangedHandler = {
                [weak self] (gamepad: GCExtendedGamepad, element: GCControllerElement) in
                
                if gamepad.buttonA.isTouched {
                    self?.playerControllerDelegate?.tryShoot()
                }
                
                if gamepad.buttonX.isTouched {
                    self?.playerControllerDelegate?.tryJump()
                }
                
                let xAxisValue = gamepad.leftThumbstick.xAxis.value
                
                if xAxisValue > 0 {
                    self?.playerControllerDelegate?.tryMove(toDirection: 1)
                } else if xAxisValue < 0 {
                    self?.playerControllerDelegate?.tryMove(toDirection: -1)
                } else if xAxisValue == 0 {
                    self?.playerControllerDelegate?.tryMove(toDirection: 0)
                }
            }
        }
    }
}
