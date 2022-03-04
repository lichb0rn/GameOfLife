//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 04.03.2022.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initScene()
    }
    
    private func initScene() {
        let scene = GameScene(size: view.bounds.size)
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
}
