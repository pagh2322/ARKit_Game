//
//  GameViewController+Node.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension GameViewController {
    
    func respawnPlayer() -> PlayerNodeContainer {
        let nodeContainer = generatePlayer()
        let (x, y, z) = getCurrentLocation()
        nodeContainer.setPosition(at: SCNVector3(x, y, z))
        sceneView.scene.rootNode.addChildNode(nodeContainer.node)
        return nodeContainer
    }

    func generatePlayer() -> PlayerNodeContainer {
        let node = PlayerNodeContainer(node: .init(geometry: SCNTube(
            innerRadius: 0,
            outerRadius: 0.25,
            height: 0.5)))
        node.setPhysicsBody()
        return node
    }
    
    func respawnBanana() -> BananaNodeContainer {
        let nodeContainer = generateBanana()
        let (x, y, z) = getCurrentLocation()
        nodeContainer.setPosition(at: SCNVector3(x, y, z))
        sceneView.scene.rootNode.addChildNode(nodeContainer.node)
        return nodeContainer
    }
    func generateBanana() -> BananaNodeContainer {
        let scene = SCNScene(named: "art.scnassets/Banana.scn")!
        let nodeContainer = BananaNodeContainer(node: scene.rootNode.childNodes[0])
        nodeContainer.node.scale = .init(0.048, 0.04, 0.048)
        nodeContainer.setPhysicsBody()
        return nodeContainer
    }
    
    func respawnMinion() {
        let nodeContainer = generateMinion()
        nodeContainer.setPosition(at: .random(isNearby: false))
        sceneView.scene.rootNode.addChildNode(nodeContainer.node)
    }
    func generateMinion() -> MinionNodeContainer {
        let scene = SCNScene(named: "art.scnassets/Minion.scn")!
        let nodeContainer = MinionNodeContainer(node: scene.rootNode.childNodes[0])
        guard let playerNode = playerNode else { return MinionNodeContainer(node: SCNNode()) }
        nodeContainer.startMoving()
        nodeContainer.activateConstraints(playerNode: playerNode)
        nodeContainer.setPhysicsBody()
        return nodeContainer
    }
    
    func respawnIceCream() {
        let nodeContainer = generateIceCream()
        nodeContainer.setPosition(at: .random(isNearby: true))
        sceneView.scene.rootNode.addChildNode(nodeContainer.node)
    }
    func generateIceCream() -> IceCreamNodeContainer {
        let scene = SCNScene(named: "art.scnassets/IceCream.scn")!
        let nodeContainer = IceCreamNodeContainer(node: scene.rootNode.childNodes[0])
        nodeContainer.node.scale = .init(0.048, 0.04, 0.048)
        nodeContainer.node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/IceCreamTexture.jpg")
        nodeContainer.setPhysicsBody()
        return nodeContainer
    }
    
}
