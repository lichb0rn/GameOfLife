//
//  GameScene.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 04.03.2022.
//

import SpriteKit

class GameScene: SKScene {
    
    private let padding: CGFloat = 2
    
    override func didMove(to view: SKView) {
        configureScene()
        
        drawGrid()
    }
    
    
    private func configureScene() {
        backgroundColor = .darkGray
    }
    
    private func drawGrid(rows: Int = 10, cols: Int = 10) {
        let minDimesnion = min(size.height, size.width)
        let cellWidth: CGFloat = minDimesnion / CGFloat(cols) - padding
        
        guard let grid = Grid(rows: rows, cols: cols, cellSize: cellWidth) else { return }
        grid.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(grid)
    }
    
    private func makeNode(at point: CGPoint, with size: CGSize) -> SKShapeNode {
        let rect = CGRect(origin: point, size: size)
        let path = CGMutablePath(rect: rect, transform: .none)
        
        let node = SKShapeNode(path: path)
        node.lineWidth = 1
        node.fillColor = .red
        
        return node
    }
}
