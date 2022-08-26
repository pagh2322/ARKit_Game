//
//  ViewController+Configuration.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import ARKit

extension ViewController {
    
    func setUpConfigurations() {
        setUpSceneView()
        addTapGestureToSceneView()
        configureLighting()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
        setUpDelegates()
        respawnPlayerNode()
        startRespawnEnemyNode()
        startRespawnLifeBoxNode()
    }
    
    func setUpDelegates() {
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    func respawnPlayerNode() {
        let _ = respawnNode(type: .player)
    }
    func startRespawnEnemyNode() {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(Float.random(in: 0.5...2)), repeats: true) { _ in
            let _ = self.respawnNode(type: .enemy)
        }
    }
    func startRespawnLifeBoxNode() {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(Float.random(in: 10...20)), repeats: true) { _ in
            let _ = self.respawnNode(type: .lifeBox)
        }
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }

    // MARK: - Attack with bullet by tapping
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func tapSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let position = recognizer.location(in: self.sceneView)
        attckByBullet(at: position)
    }
    func attckByBullet(at position: CGPoint) {
        let bulletNode = respawnNode(type: .bullet)
        applyForceToBullet(bulletNode, at: position)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            bulletNode.removeFromParentNode()
        }
    }
    
}
