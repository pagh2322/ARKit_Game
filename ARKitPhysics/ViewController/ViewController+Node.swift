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
        
        node.geometry?.materials = generateMaterials(type: type)
        node.name = type.name
        generatePhysicsBody(node, type: type)
        return node
    }
    
    func respawnEnemy() {
        let node = generateEnemy()
        setPosition(node, type: .enemy)
        sceneView.scene.rootNode.addChildNode(node)
    }
    func generateEnemy() -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/Enemy.scn")!
        let node = scene.rootNode.childNodes[0]
        
        let leftArmNode = node.childNodes.filter { $0.name == "leftArm" }.first
        leftArmNode?.runAction(generateEnmeyAction(isLeft: true))
        let rightArmNode = node.childNodes.filter { $0.name == "rightArm" }.first
        rightArmNode?.runAction(generateEnmeyAction(isLeft: false))
        let rightLegNode = node.childNodes.filter { $0.name == "rightLeg" }.first
        rightLegNode?.runAction(generateEnmeyAction(isLeft: true))
        let leftLegNode = node.childNodes.filter { $0.name == "leftLeg" }.first
        leftLegNode?.runAction(generateEnmeyAction(isLeft: false))
        
        let type = NodeType.enemy
        node.name = type.name
        let constraint = SCNLookAtConstraint(target: playerNode)
        constraint.isGimbalLockEnabled = true
        constraint.localFront = .init(1, 0, 0)
        node.constraints = [constraint]
        generatePhysicsBody(node, type: type)
        return node
    }
    func generateEnmeyAction(isLeft: Bool) -> SCNAction {
        let moveFoward = SCNAction.rotate(
            by: isLeft ? 0.4 : -0.4,
            around: .init(0, 0, 1),
            duration: 0.4)
        let moveBackward = SCNAction.rotate(
            by: isLeft ? -0.8 : 0.8,
            around: .init(0, 0, 1),
            duration: 0.8)
        let returnToOrigin = SCNAction.rotate(
            by: isLeft ? 0.4 : -0.4,
            around: .init(0, 0, 1),
            duration: 0.4)
        let actionSequence = SCNAction.sequence([moveFoward, moveBackward, returnToOrigin])
        let repeatAction = SCNAction.repeatForever(actionSequence)
        return repeatAction
    }
    
    func respawnBanana() -> SCNNode {
        let node = generateBanana()
        setPosition(node, type: .bullet)
        sceneView.scene.rootNode.addChildNode(node)
        return node
    }
    func generateBanana() -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/Banana.scn")!
        let node = scene.rootNode.childNodes[0]
        node.scale = .init(0.048, 0.04, 0.048)
        
        let type = NodeType.bullet
        node.name = type.name
        generatePhysicsBody(node, type: type)
        return node
    }
    
    func respawnIceCream() -> SCNNode {
        let node = generateIceCream()
        setPosition(node, type: .lifeBox)
        sceneView.scene.rootNode.addChildNode(node)
        return node
    }
    func generateIceCream() -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/IceCream.scn")!
        let node = scene.rootNode.childNodes[0]
        node.scale = .init(0.048, 0.04, 0.048)
        
        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/IceCreamTexture.jpg")
        
        let type = NodeType.lifeBox
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
            shape: .init(node: node))
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
