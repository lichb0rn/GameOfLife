//
//  MainScreenScene.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 05.03.2022.
//

import SpriteKit
import UIKit

class StartScene: SKScene {
    
    var game = GameModel(rows: 10, cols: 10)
    
    let chooseLabel = SKLabelNode(text: "Initial settings")
    let rowsLabel = SKLabelNode(text: "Rows:")
    let colsLabel = SKLabelNode(text: "Cols:")
    var rowsTextField: UITextField!
    var colsTextField: UITextField!
    let startButton = SKSpriteNode(imageNamed: "StartButton")
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = SKColor.black
        
        configureUI()
    }
    
    private func configureUI() {
        chooseLabel.fontSize = 38
        chooseLabel.fontName = "Arial"
        chooseLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        chooseLabel.fontColor = SKColor.white
        addChild(chooseLabel)
        
        rowsLabel.fontSize = 24
        rowsLabel.fontName = "Arial"
        rowsLabel.position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY + 20)
        rowsLabel.fontColor = SKColor.white
        addChild(rowsLabel)
        
        rowsTextField = makeTextField(at: CGPoint(x: self.size.width / 2 + 20, y: self.size.height / 2 - 45))
        
        colsLabel.fontSize = 24
        colsLabel.fontName = "Arial"
        colsLabel.position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY - 20)
        colsLabel.fontColor = SKColor.white
        addChild(colsLabel)
        
        colsTextField = makeTextField(at: CGPoint(x: self.size.width / 2 + 20, y: self.size.height / 2 - 5))
        
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        startButton.setScale(0.5)
        addChild(startButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if atPoint(location) == startButton {
                startGame()
            }
        }
    }
    
    private func startGame() {
        let scene = GameScene(size: self.size)
        scene.game = makeNewGame()
        
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
        self.view?.presentScene(scene, transition: transition)
        
        colsTextField.removeFromSuperview()
        rowsTextField.removeFromSuperview()
    }
    
    private func makeNewGame() -> GameModel {
        let rowString = rowsTextField.text ?? "10"
        let colString = colsTextField.text ?? "10"
        
        let rows = Int(rowString) ?? 10
        let cols = Int(colString) ?? 10
        
        let newGame = GameModel(rows: rows, cols: cols)
        return newGame
    }
    
    private func makeTextField(at position: CGPoint, placeholder: String = "Your ad could be here :-)") -> UITextField {
        let textField = UITextField(frame: CGRect(origin: position,
                                                  size: CGSize(width: 100, height: 30)))
        
        
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.textColor = .white
        textField.textAlignment = .right
        textField.backgroundColor = .black
        textField.placeholder = placeholder
        textField.keyboardType = .numberPad
        textField.delegate = self
        self.view?.addSubview(textField)
        
        return textField
    }
    
}


extension StartScene: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedInput = CharacterSet.decimalDigits
        let characters = CharacterSet(charactersIn: string)
        return allowedInput.isSuperset(of: characters)
    }
}
