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
        sceneView.scene.rootNode.childNodes
            .filter { $0.name == NodeType.enemy.name }
            .forEach {
                let currentTransform = frame.camera.transform
                $0.runAction(.move(to: SCNVector3(currentTransform.translation), duration: 2))
            }
    }
}
