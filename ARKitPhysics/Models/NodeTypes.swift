//
//  NodeTypes.swift
//  ARKitPhysics
//
//  Created by peo on 2022/09/01.
//  Copyright © 2022 AppCoda. All rights reserved.
//

enum NodeBitMask: Int {
    case banana = 0x1
    case minion = 0x2
    case iceCream = 0x4
    case player = 0x8
}

protocol NodeTypeConfiguration {
    var name: String { get }
    var categoryBitMask: Int { get }
    var contactTestBitMask: Int { get }
    var collisionBitMask: Int { get }
}

struct BananaNodeType: NodeTypeConfiguration {
    var name: String { return "banana" }
    var categoryBitMask: Int { return NodeBitMask.banana.rawValue }
    var contactTestBitMask: Int { return NodeBitMask.minion.rawValue }
    var collisionBitMask: Int { return NodeBitMask.minion.rawValue | NodeBitMask.iceCream.rawValue }
}

struct MinionNodeType: NodeTypeConfiguration {
    var name: String { return "minion" }
    var categoryBitMask: Int { return NodeBitMask.minion.rawValue }
    var contactTestBitMask: Int { return 0x1 | 0x4 }
    var collisionBitMask: Int { return 0x2 | 0x4 | 0x8 }
}

struct IceCreamNodeType: NodeTypeConfiguration {
    var name: String { return "iceCream" }
    var categoryBitMask: Int { return 0x4 }
    var contactTestBitMask: Int { return 0x8 | 0x4 }
    var collisionBitMask: Int { return 0x2 | 0x4 }
}

struct PlayerNodeType: NodeTypeConfiguration {
    var name: String { return "player" }
    var categoryBitMask: Int { return 0x8 }
    var contactTestBitMask: Int { return 0x2 | 0x4 }
    var collisionBitMask: Int { return 0x2 | 0x4 }
}
