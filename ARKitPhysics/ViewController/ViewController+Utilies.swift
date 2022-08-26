//
//  ViewController+Utilies.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension ViewController {
    
    func fetchForceDirection(at position: CGPoint) -> simd_float3? {
        guard let hitTestResult = sceneView.raycastQuery(from: position, allowing: .existingPlaneGeometry, alignment: .any) else { return nil }
        return hitTestResult.direction
    }
    
    func getCurrentLocation() -> (x: Float, y: Float, z: Float) {
        guard let direction = sceneView.session.currentFrame?.camera.transform.translation else { return (0, 0, 0) }
        return (direction.x, direction.y, direction.z)
    }
    
    func applyForceToBullet(_ node: SCNNode, at position: CGPoint) {
        guard let physicsBody = node.physicsBody else { return }
        
        guard let direction = fetchForceDirection(at: position) else { return }
        physicsBody.applyForce(SCNVector3(direction * 4), asImpulse: true)
    }
    
}
