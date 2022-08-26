//
//  ViewController.swift
//  ARKitPhysics
//
//  Created by Jayven Nhan on 12/24/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var lifeCountLabel: UILabel!
    
    var isGameOver = false
    var scoreCount = 0 {
        didSet {
            DispatchQueue.main.async {
                self.scoreCountLabel.text = "\(self.scoreCount)"
            }
        }
    }
    var lifeCount = 5 {
        didSet {
            DispatchQueue.main.async {
                self.lifeCountLabel.text = "\(self.lifeCount) / 5"
            }
        }
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
}
