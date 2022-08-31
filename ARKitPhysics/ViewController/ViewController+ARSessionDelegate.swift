//
//  ViewController+ARSessionDelegate.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension ViewController: ARSessionDelegate {
    func session(
        _ session: ARSession,
        didUpdate frame: ARFrame
    ) {
        let currentTransform = frame.camera.transform
        playerNode?.runAction(.move(to: SCNVector3(currentTransform.translation), duration: 0.5))
        sceneView.scene.rootNode.childNodes
            .filter { $0.name == NodeType.enemy.name }
            .forEach {
                $0.runAction(.move(to: SCNVector3(currentTransform.translation), duration: 2))
                
                let constraint = SCNLookAtConstraint(target: playerNode)
                constraint.isGimbalLockEnabled = true
                constraint.localFront = .init(1, 0, 0)
                $0.constraints = [constraint]
            }
    }
}
