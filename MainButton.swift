//
//  MainButton.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 21/11/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class MainButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor(hue:0.43, saturation:0.43, brightness:1.00, alpha:1.00).cgColor
        self.layer.cornerRadius = 5
        
        self.titleLabel?.font = UIFont(name: NOTO_SANS_REG, size: 23)
        self.setTitleColor(UIColor(hue:0.57, saturation:0.03, brightness:0.60, alpha:1.00), for: .normal)
        self.setTitleColor(UIColor(hue:0.00, saturation:0.00, brightness:0.93, alpha:1.00), for: .highlighted)
    }
}

