//
//  NodeType.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import SceneKit

enum NodeType {
    case bullet
    case enemy
    case lifeBox
    case player
    
    var name: String {
        switch self {
        case .bullet: return "bullet"
        case .enemy: return "enemy"
        case .lifeBox: return "lifeBox"
        case .player: return "player"
        }
    }
    
    var categoryBitMask: Int {
        switch self {
        case .bullet: return 0x1
        case .enemy: return 0x2
        case .lifeBox: return 0x4
        case .player: return 0x8
        }
    }
    
    var contactTestBitMask: Int {
        switch self {
        case .bullet: return 0x2
        case .enemy: return 0x1 | 0x8
        case .lifeBox: return 0x8
        case .player: return 0x2 | 0x4
        }
    }
    
    var collisionBitMask: Int {
        switch self {
        case .bullet: return 0x2 | 0x4
        case .enemy: return 0x1 | 0x4 | 0x8
        case .lifeBox: return 0x1 | 0x2 | 0x8
        case .player: return 0x2 | 0x4
        }
    }
    
    var materialContents: UIColor {
        switch self {
        case .bullet:
            return UIColor(
                red: 0.95,
                green: 0.75,
                blue: 0.2,
                alpha: 1.0)
        case .enemy:
            return .random ?? .orange
        case .lifeBox:
            return .cyan
        case .player:
            return .clear
        }
    }
}
