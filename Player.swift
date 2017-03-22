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
    let highscore: Int!
    
    init(user name: String, withID id: String, highscore points: Int) {
        self.name = name
        self.id = id
        self.highscore = points
    }

}
