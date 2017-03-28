//
//  File.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 28/03/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import Foundation

class WordToGuess {
    
    let word: [String]
    let id: String
    
    init(words: [String], withId: String) {
        word = words
        id = withId
    }
    
}
