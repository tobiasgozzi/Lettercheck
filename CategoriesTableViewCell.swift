//
//  CategorieTabelViewCell.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 21/12/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class CategoriesTableViewCell : UITableViewCell {
    
    @IBOutlet weak var button: MainButton!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    
    func configureCell(name: String) {
        //self.button = MainButton()
        print("confCell \(name)")
        button.setTitle(name, for: .normal)
        //button.addTarget(self, action: Selector("startGame"), for: .touchUpInside)
    }
    
    
    func startGame() {
      //  print(button.title(for: .normal) ?? "notitle")
        
    }
}
