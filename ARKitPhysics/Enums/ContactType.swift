//
//  ContactType.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

enum ContactType {
    /// True: nodeA is bullet, False: nodeB is bullet
    case bulletAndEnemy(Bool)
    /// True: nodeA is player, False: nodeB is player
    case playerAndEnemy(Bool)
    /// True: nodeA is player, False: nodeB is player
    case playerAndLifeBox(Bool)
}
