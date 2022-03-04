//
//  Grid.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 04.03.2022.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    private var rows: Int!
    private var cols: Int!
    private var cellSize: CGFloat!

    
    convenience init?(rows: Int, cols: Int, cellSize: CGFloat) {
        guard let texture = Grid.backgroundTexture(rows: rows, cols: cols, cellSize: cellSize) else {
            return nil
        }
        
        self.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.rows = rows
        self.cols = cols
        self.cellSize = cellSize
    }
    
    class func backgroundTexture(rows: Int, cols: Int, cellSize: CGFloat) -> SKTexture? {
        let size = CGSize(width: CGFloat(cols) * cellSize + 1.0,
                          height: CGFloat(rows) * cellSize + 1.0)
        
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let path = UIBezierPath()
        let offset: CGFloat = 0.5
        
        for i in 0...cols {
            let xPos = CGFloat(i) * cellSize + offset
            path.move(to: CGPoint(x: xPos, y: 0))
            path.addLine(to: CGPoint(x: xPos, y: size.height))
        }
        
        for i in 0...rows {
            let yPos = CGFloat(i) * cellSize + offset
            path.move(to: CGPoint(x: 0, y: yPos))
            path.addLine(to: CGPoint(x: size.width, y: yPos))
        }
        
        SKColor.white.setStroke()
        path.lineWidth = 1.0
        path.stroke()
        context.addPath(path.cgPath)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
}
