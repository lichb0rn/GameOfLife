//
//  GameScene.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 04.03.2022.
//

import SpriteKit

class GameScene: SKScene {
    
    var game: GameModel!
    var timer = Timer()
    var cells: [SKSpriteNode] = []
    
    private let padding: CGFloat = 2
    private var automaTexture: SKTexture?
    
    var tileGrid: SKTileMapNode!
    let aliveLabel = SKLabelNode(text: "0")
    let generationLabel = SKLabelNode(text: "0")
    
    private var stopper: Int = 20

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        configureScene()

        let minDimension = min(size.height, size.width)
        let cellWidth = minDimension / CGFloat(game.cols) - padding
        let cellSize = CGSize(width: cellWidth, height: cellWidth)
        
        let automaImage = UIImage(named: "cell")?.resize(with: cellSize)
        automaTexture = SKTexture(image: automaImage!)
        
        tileGrid = initializeGrid(rows: game.rows,
                       cols: game.cols,
                       cellSize: cellSize)
        
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(allMenMustDie), userInfo: nil, repeats: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateLife()
        
        if game.alive == 0 {
            gameOver()
        }
        
        // For debug purposes
        if stopper <= 0 {
            gameOver()
        }
        
        
        aliveLabel.text = "Alive: \(game.alive)"
        generationLabel.text = "Generation: \(game.generation)"
        
        
    }
    
    
    private func initializeGrid(rows: Int, cols: Int, cellSize: CGSize) -> SKTileMapNode {
        let tileTexture = cellTexture(with: cellSize)
        let tileDefinition = SKTileDefinition(texture: tileTexture!)
        let tileGroup = SKTileGroup(tileDefinition: tileDefinition)
        let tileSet = SKTileSet(tileGroups: [tileGroup], tileSetType: .grid)
        
        let tileGrid = SKTileMapNode(tileSet: tileSet,
                                 columns: cols,
                                 rows: rows,
                                 tileSize: tileSet.defaultTileSize)
        
        tileGrid.fill(with: tileGroup)
        tileGrid.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(tileGrid)
        return tileGrid
    }

    @objc private func allMenMustDie() {
        stopper -= 1
        game.nextGeneration()
    }
    
    private func updateLife() {
        tileGrid.removeAllChildren()
        var cellsToRemove: [SKNode] = []
        for i in 0..<tileGrid.numberOfColumns {
            for j in 0..<tileGrid.numberOfRows {
                let name = "\(i)-\(j)"
                if game.automas[j][i].status == .alive {
//                    guard let _ = tileGrid.childNode(withName: name) else { continue }
                    addCellAt(row: j, col: i)
                } else {
                    guard let cell = tileGrid.childNode(withName: name) else { continue }
                    cellsToRemove.append(cell)
                }
            }
        }
//        tileGrid.removeChildren(in: cellsToRemove)
    }
    
    private func addCellAt(row: Int, col: Int) {
        let cell = SKSpriteNode(texture: automaTexture)
        cell.position = tileGrid.centerOfTile(atColumn: col, row: row)
        cell.name = "\(row)-\(col)"
        tileGrid.addChild(cell)
    }
    
    private func cellToRemoveAt(row: Int, col: Int, cells: inout [SKNode]) {
        let name = "\(row)-\(col)"
        guard let child = tileGrid.childNode(withName: name) else { return }
        cells.append(child)
    }
    
    private func gameOver() {
        timer.invalidate()
        let gameOverScene = GameOver(size: self.size)
        gameOverScene.game = game
        let transition = SKTransition.fade(withDuration: 2)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}


extension GameScene {
    private func configureScene() {
        backgroundColor = SKColor.black
        
        aliveLabel.position = CGPoint(x: frame.midX - 100, y: frame.maxY - 50)
        aliveLabel.fontName = "Arial"
        generationLabel.position = CGPoint(x: frame.midX + 100, y: frame.maxY - 50)
        generationLabel.fontName = "Arial"
        
        addChild(aliveLabel)
        addChild(generationLabel)
    }
    
    
    // Since I don't want to use any kind of specific texture right now
    // I'm just generating a square with white borders
    private func cellTexture(with size: CGSize) -> SKTexture? {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(1.0)
        context.addRect(CGRect(origin: .zero, size: size))
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
}
