//
//  StartViewController.swift
//  ARKitPhysics
//
//  Created by peo on 2022/09/01.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit
import SceneKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSceneView()
        setUpStartButton()
    }

}

extension StartViewController {
    func setUpSceneView() {
        let scene = SCNScene(named: "art.scnassets/Banana.scn")!

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 20)
        scene.rootNode.addChildNode(cameraNode)

        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = cameraNode.position
        scene.rootNode.addChildNode(lightNode)

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = self.view.backgroundColor
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.scene = scene
        rotateBanana(scene.rootNode.childNodes[0])
    }
    
    func rotateBanana(_ node: SCNNode) {
        let actionX = SCNAction.repeatForever(.rotateBy(x: 0, y: .pi / 2, z: 0, duration: 0.5))
        node.runAction(actionX)
    }
}

extension StartViewController {
    func setUpStartButton() {
        startButton.addTarget(self, action: #selector(goToGameView), for: .touchUpInside)
    }
    
    @objc func goToGameView() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
