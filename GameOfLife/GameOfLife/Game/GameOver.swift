//
//  GameOver.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 07.03.2022.
//

import SpriteKit

class GameOver: SKScene {
    
    var game: GameModel!
    
    let gameOverLabel = SKLabelNode(text: "Game Over")
    let generationLabel = SKLabelNode(text: "Population died")
    let minLabel = SKLabelNode(text: "Min life count:")
    let maxLabel = SKLabelNode(text: "Max life count:")
    let againLabel = SKLabelNode(text: "Start over?")
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = SKColor.black
        
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.color = SKColor.red
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 250)
        addChild(gameOverLabel)
        
        generationLabel.fontName = "Arial"
        generationLabel.color = SKColor.white
        generationLabel.fontSize = 16
        generationLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        generationLabel.text = "All life stopped at \(game.generation) generation."
        addChild(generationLabel)
        
        minLabel.fontName = "Arial"
        minLabel.color = SKColor.white
        minLabel.fontSize = 20
        minLabel.text = "Min life count: \(game.minCount)"
        minLabel.position = CGPoint(x: frame.midX - 200, y: frame.midY - 100)
        addChild(minLabel)
        
        maxLabel.fontName = "Arial"
        maxLabel.color = SKColor.white
        maxLabel.fontSize = 20
        maxLabel.text = "Max life count: \(game.maxCount)"
        maxLabel.position = CGPoint(x: frame.midX + 200, y: frame.midY - 100)
        addChild(maxLabel)
        
        againLabel.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        againLabel.fontSize = 30
        againLabel.fontName = "Helvetica Nue"
        againLabel.fontColor = SKColor.green
        addChild(againLabel)
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if atPoint(location) == againLabel {
                let scene = StartScene(size: self.size)
                
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}
