//
//  Automa.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 06.03.2022.
//

import Foundation

struct Automa {
    
    enum Status {
        case dead
        case alive
    }
    
    var status: Status
    init(status: Status) {
        self.status = status
    }
}
