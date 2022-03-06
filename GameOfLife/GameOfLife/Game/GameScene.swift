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
        
        addCell(at: tileGrid.centerOfTile(atColumn: 0, row: 1))
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
    
    private func addCell(at position: CGPoint) {
        let cell = SKSpriteNode(texture: automaTexture)
        cell.position = position
        tileGrid.addChild(cell)
    }
    
}


extension GameScene {
    private func configureScene() {
        backgroundColor = SKColor.black
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
