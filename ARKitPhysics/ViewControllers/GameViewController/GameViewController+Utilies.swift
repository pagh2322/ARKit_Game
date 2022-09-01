//
//  GameViewController+Utilies.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension GameViewController {
    
    func fetchForceDirection(at position: CGPoint) -> simd_float3? {
        guard
            let hitTestResult = sceneView.raycastQuery(
            from: position,
            allowing: .existingPlaneGeometry,
            alignment: .any)
        else {
            return nil
        }
        return hitTestResult.direction
    }
    
    func getCurrentLocation() -> (
        x: Float,
        y: Float,
        z: Float
    ) {
        guard
            let direction = sceneView.session.currentFrame?.camera.transform.translation
        else {
            return (0, 0, 0)
        }
        return (direction.x, direction.y, direction.z)
    }
    
}
