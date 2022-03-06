//
//  GameModel.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 05.03.2022.
//

import Foundation

fileprivate let liveRange = 2...3
fileprivate let overpopulationRange = 4...
fileprivate let underpopulation = 0..<2


struct GameModel {
    
    let rows: Int
    let cols: Int
    
    var generation: Int = 0
    var alive: Int = 0
    
    // initial set up
    lazy var automas: [[Automa]] = Array(repeating: Array(repeating: Automa(status: .dead), count: rows),
                                         count: cols)
    
    init(rows: Int, cols: Int) {
        // Fundamental restriction
        // Higher values look bad on iPhone and iPad
        self.rows = (rows > 10) && (rows < 100) ? rows : 10
        self.cols = (cols > 10) && (cols < 100) ? cols : 10
        generateInitialLife()
    }
    
    private mutating func generateInitialLife() {
        for i in 0..<rows {
            for j in 0..<cols {
                let godsWill = Int.random(in: 0...100)
                if (0...30).contains(godsWill)  {
                    automas[i][j] = Automa(status: .alive)
                    alive += 1
                } else {
                    automas[i][j] = Automa(status: .dead)
                }
            }
        }
        
        print("ALIVE: \(alive)")
    }
    
    
    mutating func nextGeneration() {
        var lastGen = automas
        
        for i in 0..<rows {
            for j in 0..<cols {
                
                let neighborsCount = neighborsCountAt(row: i, col: j, in: &lastGen)
                
                if (lastGen[i][j].status == .alive) && (liveRange.contains(neighborsCount)) {
                    automas[i][j].status = .alive
                } else if (lastGen[i][j].status == .dead) && (liveRange.contains(neighborsCount)) {
                    automas[i][j].status = .alive
                } else {
                    automas[i][j].status = .dead
                }
            }
        }
        
        generation += 1
    }
    
    private mutating func neighborsCountAt(row: Int, col: Int, in cells: inout [[Automa]]) -> Int {
        var neighbors = 0
        
        // Right
        if (row + 1 < rows) && (cells[row + 1][col].status != .dead) {
            neighbors += 1
        }
        
        // Left
        if (row - 1 >= 0) && (cells[row - 1][col].status != .dead) {
            neighbors += 1
        }
        
        // Above
        if (col + 1 < cols) && (cells[row][col + 1].status != .dead) {
            neighbors += 1
        }
        
        // Below
        if (col - 1 >= 0) && (cells[row][col - 1].status != .dead) {
            neighbors += 1
        }
        
        return neighbors
    }
}
