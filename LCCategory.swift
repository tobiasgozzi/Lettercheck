//
//  Categories.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 28/03/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import Foundation

struct LCCategory {
    
    //Name and translations of the category
    let names: [String]
    let id : String
    
    init(withNames translations: [String], id: String) {
        self.names = translations
        self.id = id
    }
}
