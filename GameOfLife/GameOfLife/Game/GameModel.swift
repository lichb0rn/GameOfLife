//
//  GameModel.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 05.03.2022.
//

import Foundation


struct GameModel {
    
    let rows: Int
    let cols: Int
    
    var generation: Int = 1
    
    // initial set up
    lazy var automas: [[Automa]] = {
        var array: [[Automa]] = []
        for i in 0..<rows {
            for j in 0..<cols {
                let godsWill = Int.random(in: 0...1)
                array[i][j] = godsWill == 1 ? Automa(status: .alive) : Automa(status: .dead)
            }
        }
        return array
    }()
    
    init(rows: Int, cols: Int) {
        // Fundamental restriction
        // Higher values look bad on iPhone and iPad
        self.rows = (rows > 10) && (rows < 100) ? rows : 10
        self.cols = (cols > 10) && (cols < 100) ? cols : 10
    }
    
    func nextGeneration() {
        
        
    }
}
