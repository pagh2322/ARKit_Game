//
//  BasicNode+NodeConfiguration.swift
//  ARKitPhysics
//
//  Created by peo on 2022/09/01.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import SceneKit

protocol NodeContainerConfiguration: AnyObject {
    var node: SCNNode { get set }
    var nodeType: NodeType? { get set }
    func setPosition(at position: SCNVector3)
    func setPhysicsBody()
}

class BasicNodeContainer: NodeContainerConfiguration {
    
    var node: SCNNode
    
    var nodeType: NodeType?
    
    init(
        node: SCNNode,
        nodeType: NodeType
    ) {
        self.node = node
        self.nodeType = nodeType
        self.node.name = nodeType.name
    }
    
    func setPosition(at position: SCNVector3) {
        node.position = position
    }
    
    func setPhysicsBody() {
        let physicsBody = SCNPhysicsBody(
            type: .dynamic,
            shape: .init(node: node))
        physicsBody.isAffectedByGravity = false
        guard let nodeType = nodeType else { return }
        physicsBody.categoryBitMask = nodeType.categoryBitMask
        physicsBody.contactTestBitMask = nodeType.contactTestBitMask
        physicsBody.collisionBitMask = nodeType.collisionBitMask
        node.physicsBody = physicsBody
    }
    
}

final class BananaNodeContainer: BasicNodeContainer {
    
    convenience init(node: SCNNode) {
        self.init(node: node, nodeType: .banana)
    }
    
    func applyForce(_ direction: simd_float3) {
        guard let physicsBody = self.node.physicsBody else { return }
        physicsBody.applyForce(SCNVector3(direction * 4),
                               asImpulse: true)
    }
    
}

final class MinionNodeContainer: BasicNodeContainer {
    
    convenience init(node: SCNNode) {
        self.init(node: node, nodeType: .minion)
    }
    
    var forwardAction: SCNAction {
        return SCNAction.repeatForever(generateSequenceAction(isForward: true))
    }
    
    var backwardAction: SCNAction {
        return SCNAction.repeatForever(generateSequenceAction(isForward: false))
    }
    
    // Arms and legs are moving
    func startMoving() {
        let leftArmNode = self.node.childNodes.filter { $0.name == "leftArm" }.first
        leftArmNode?.runAction(forwardAction)
        let rightArmNode = self.node.childNodes.filter { $0.name == "rightArm" }.first
        rightArmNode?.runAction(backwardAction)
        let rightLegNode = self.node.childNodes.filter { $0.name == "rightLeg" }.first
        rightLegNode?.runAction(forwardAction)
        let leftLegNode = self.node.childNodes.filter { $0.name == "leftLeg" }.first
        leftLegNode?.runAction(backwardAction)
    }
    
    func generateSequenceAction(isForward: Bool) -> SCNAction {
        let moveFoward = SCNAction.rotate(
            by: isForward ? 0.4 : -0.4,
            around: .init(0, 0, 1),
            duration: 0.4)
        let moveBackward = SCNAction.rotate(
            by: isForward ? -0.8 : 0.8,
            around: .init(0, 0, 1),
            duration: 0.8)
        let returnToOrigin = SCNAction.rotate(
            by: isForward ? 0.4 : -0.4,
            around: .init(0, 0, 1),
            duration: 0.4)
        return SCNAction.sequence([moveFoward,
                                   moveBackward,
                                   returnToOrigin])
    }
    
    func activateConstraints(playerNode: SCNNode) {
        let constraint = SCNLookAtConstraint(target: playerNode)
        constraint.isGimbalLockEnabled = true
        constraint.localFront = .init(1, 0, 0)
        self.node.constraints = [constraint]
    }
    
    func moveTowards(to playerPosition: SIMD3<Float>) {
        self.node.runAction(.move(to: SCNVector3(playerPosition),
                             duration: 2))
    }
    
}

final class IceCreamNodeContainer: BasicNodeContainer {
    
    convenience init(node: SCNNode) {
        self.init(node: node, nodeType: .iceCream)
    }
    
}

final class PlayerNodeContainer: BasicNodeContainer {
    
    convenience init(node: SCNNode) {
        self.init(node: node, nodeType: .player)
    }
    
}
