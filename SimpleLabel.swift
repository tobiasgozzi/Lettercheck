//
//  SimpleLabel.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 26/01/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit

class SimpleLabel: UILabel {

    
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
        self.textColor = UIColor(hue:0.40, saturation:0.5, brightness:0.93, alpha:1.00)
//        self.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.93, alpha:1.00)
//        self.layer.borderColor = UIColor(hue:0.00, saturation:0.00, brightness:0.93, alpha:0.00).cgColor
//        self.layer.cornerRadius = 20
        self.font = UIFont(name: NOTO_SANS_REG, size: 25)

    }

}
