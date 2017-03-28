//
//  Player.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 28/11/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation

class Player {
    
    let name: String!
    let id: String!
    var highscore: Int! {
        didSet {
            level = gamesWithoutError / 5
        }
    }
    var gamesWithoutError: Int!
    
    var level: Int!
    
    init(user name: String, withID id: String, highscore points: Int, gamesWithoutError: Int) {
        self.name = name
        self.id = id
        self.highscore = points
        self.gamesWithoutError = gamesWithoutError
    }
    
    func setLvl() {
        gamesWithoutError = highscore / 5
    }

}

