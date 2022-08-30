//
//  ViewController+Node.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension ViewController {
    
    func respawnNode(type: NodeType) -> SCNNode {
        let node = generateNode(type: type)
        setPosition(node, type: type)
        sceneView.scene.rootNode.addChildNode(node)
        return node
    }

    func generateNode(type: NodeType) -> SCNNode {
        let node = SCNNode()
        node.geometry = type.geometry
        
        node.geometry?.materials = generateMaterials(type: type)
        node.name = type.name
        generatePhysicsBody(node, type: type)
        return node
    }
    
    func generateMaterials(type: NodeType) -> [SCNMaterial] {
        let material = SCNMaterial()
        material.lightingModel = .physicallyBased
        material.metalness.contents = 1.0
        material.roughness.contents = 0.0
        
        material.diffuse.contents = type.materialContents
        return [material]
    }
    
    func generatePhysicsBody(
        _ node: SCNNode,
        type: NodeType
    ) {
        let physicsBody = SCNPhysicsBody(
            type: .dynamic,
            shape: SCNPhysicsShape(geometry: node.geometry!))
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = type.categoryBitMask
        physicsBody.contactTestBitMask = type.contactTestBitMask
        physicsBody.collisionBitMask = type.collisionBitMask
        node.physicsBody = physicsBody
    }
    
    func setPosition(
        _ node: SCNNode,
        type: NodeType
    ) {
        switch type {
        case .bullet, .player:
            let (x, y, z) = getCurrentLocation()
            node.position = SCNVector3(x, y, z)
        case .enemy:
            node.position = SCNVector3.random(isNearby: false)
        case .lifeBox:
            node.position = SCNVector3.random(isNearby: true)
        }
    }
    
}
