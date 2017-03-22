//
//  LetterCell.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 17/01/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit

class LetterCell: UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    let guessLabel = "_"
    var hiddenCharacter: Character?
    

    func configureCell(){
        label.text = String(hiddenCharacter!)
        
    }
}
