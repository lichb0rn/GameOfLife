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
    
    init(rows: Int, cols: Int) {
        // Fundamental restriction
        // Higher values look bad on iPhone and iPad
        self.rows = (rows > 10) && (rows < 100) ? rows : 10
        self.cols = (cols > 10) && (cols < 100) ? cols : 10
    }
}
