//
//  CameraFollowComponent.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 10/02/23.
//

import Foundation
import SpriteKit
import GameplayKit

class CameraFollowComponent: GKComponent {
    
    var camera: SKCameraNode
    var node: SKNode?
    
    init(camera: SKCameraNode) {
        self.camera = camera
        super.init()
    }
    
    override func didAddToEntity() {
        node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        camera.position = node?.position ?? .zero
        
    }
    
}
