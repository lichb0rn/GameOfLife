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

        startScene()
    }
    
    private func startScene() {
        let startScene = StartScene(size: view.bounds.size)
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        startScene.scaleMode = .resizeFill
        
        skView.presentScene(startScene)
    }
}
