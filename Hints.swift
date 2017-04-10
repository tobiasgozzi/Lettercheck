//
//  Hints.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 28/03/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import Foundation

struct Hints {


    let forWordId: String
    let hintsMulitlang: [[String]]
    let fromCategory: String
    
    init(word: String, hints: [[String]], category: String) {
        
        self.forWordId = word
        self.hintsMulitlang = hints
        self.fromCategory = category
        
    }

}

