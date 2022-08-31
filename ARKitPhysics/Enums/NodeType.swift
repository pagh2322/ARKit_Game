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
    case banana
    case minion
    case iceCream
    case player
    
    var name: String {
        switch self {
        case .banana: return "banana"
        case .minion: return "minion"
        case .iceCream: return "iceCream"
        case .player: return "player"
        }
    }
    
    var categoryBitMask: Int {
        switch self {
        case .banana: return 0x1
        case .minion: return 0x2
        case .iceCream: return 0x4
        case .player: return 0x8
        }
    }
    
    var contactTestBitMask: Int {
        switch self {
        case .banana: return 0x2
        case .minion: return 0x1 | 0x8
        case .iceCream: return 0x8
        case .player: return 0x2 | 0x4
        }
    }
    
    var collisionBitMask: Int {
        switch self {
        case .banana: return 0x2 | 0x4
        case .minion: return 0x1 | 0x4 | 0x8
        case .iceCream: return 0x1 | 0x2 | 0x8
        case .player: return 0x2 | 0x4
        }
    }
}
