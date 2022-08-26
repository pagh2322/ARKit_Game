//
//  ViewController+SCNPhysicsContactDelegate.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension ViewController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        guard let contactType = checkContactType(contact.nodeA, contact.nodeB) else { return }
        
        switch contactType {
        case .bulletAndEnemy(let bool):
            if bool {
                didBulletEnemyContact(contact.nodeB, contact.nodeA, at: contact.contactPoint)
            } else {
                didBulletEnemyContact(contact.nodeA, contact.nodeB, at: contact.contactPoint)
            }
        case .playerAndEnemy(let bool):
            if bool {
                didPlayerEnemyContact(contact.nodeB)
            } else {
                didPlayerEnemyContact(contact.nodeA)
            }
        case .playerAndLifeBox(let bool):
            if bool {
                didPlayerLifeBoxContact(contact.nodeB)
            } else {
                didPlayerLifeBoxContact(contact.nodeA)
            }
        }
    }
    
    func checkContactType(_ nodeA: SCNNode, _ nodeB: SCNNode) -> ContactType? {
        let resultBitMask = nodeA.physicsBody!.categoryBitMask + nodeB.physicsBody!.categoryBitMask
        switch resultBitMask {
        case 3:
            if nodeA.physicsBody!.categoryBitMask == 0x1 {
                return .bulletAndEnemy(true)
            } else {
                return .bulletAndEnemy(false)
            }
        case 10:
            if nodeA.physicsBody!.categoryBitMask == 0x8 {
                return .playerAndEnemy(true)
            } else {
                return .playerAndEnemy(false)
            }
        case 12:
            if nodeA.physicsBody!.categoryBitMask == 0x8 {
                return .playerAndLifeBox(true)
            } else {
                return .playerAndLifeBox(false)
            }
        default: return nil
        }
    }
    
    func didBulletEnemyContact(_ bulletNode: SCNNode, _ enemyNode: SCNNode, at location: SCNVector3) {
        scoreCount += Int.random(in: 1...5)
        
        guard let particleNode = generateParticleNode(location: location) else { return }
        
        bulletNode.removeFromParentNode()
        enemyNode.removeFromParentNode()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            particleNode.removeFromParentNode()
        }
    }
    
    func didPlayerEnemyContact(_ enemyNode: SCNNode) {
        lifeCount -= 1
        if lifeCount < 0 {
            isGameOver = true
        }
        enemyNode.removeFromParentNode()
    }
    
    func didPlayerLifeBoxContact(_ lifeBoxNode: SCNNode) {
        if lifeCount < 5 {
            lifeCount += 1
        }
        lifeBoxNode.removeFromParentNode()
    }
    
    func generateParticleNode(location: SCNVector3) -> SCNNode? {
        guard let particleSystem = SCNParticleSystem(named: "reactor", inDirectory: nil) else { return nil }
        particleSystem.particleSize = 0.1
        
        let particlesNode = SCNNode()
        particlesNode.addParticleSystem(particleSystem)
        particlesNode.position = location
        sceneView.scene.rootNode.addChildNode(particlesNode)
        return particlesNode
    }
}

