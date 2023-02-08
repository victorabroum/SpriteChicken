//
//  DefaultAnimations.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 03/02/23.
//

import Foundation
import SpriteKit

extension SKAction {
    
    public static func hurtAnimation() -> SKAction {
        return .sequence([
            .playSoundFileNamed("hurt.wav", waitForCompletion: false),
            .repeat(.sequence([
                .fadeAlpha(to: 0, duration: 0.05),
                .fadeAlpha(to: 1, duration: 0.05),
            ]), count: 6),
        ])
    }
    
}
