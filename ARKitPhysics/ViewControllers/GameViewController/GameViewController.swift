//
//  GameViewController.swift
//
//  Created by Jayven Nhan on 12/24/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import ARKit

class GameViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var lifeCountLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var playerNode: SCNNode?
    
    var isGameOver = false {
        didSet {
            if isGameOver {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "게임 종료", message: "획득 점수: \(self.scoreCount)", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "홈으로", style: .destructive) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(confirmAction)
                    self.present(alert, animated: true)
                }
            }
        }
    }
    var scoreCount = 0 {
        didSet {
            DispatchQueue.main.async {
                self.scoreCountLabel.text = "\(self.scoreCount)"
            }
        }
    }
    var lifeCount = 7 {
        didSet {
            DispatchQueue.main.async {
                self.lifeCountLabel.text = "\(self.lifeCount) / 7"
                if self.lifeCount == 0 {
                    self.sceneView.scene.isPaused = true
                    self.isGameOver = true
                }
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
