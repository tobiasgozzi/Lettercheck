//
//  File.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 28/03/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import Foundation

class WordToGuess {
    
    //word and it's translations
    let multilangWord: [String]
    let id: String
    let categoryId: String
    
    init(words: [String], withId: String, from category: String) {
        self.multilangWord = words
        self.id = withId
        self.categoryId = category
    }
    
}
