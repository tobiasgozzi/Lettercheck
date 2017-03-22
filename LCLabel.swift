//
//  LCLabel.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 21/11/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class LCLTextField: UITextField {


    override func draw(_ rect: CGRect) {
        layer.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.93, alpha:1.00).cgColor
        self.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.93, alpha:1.00)
        self.layer.borderColor = UIColor(hue:0.00, saturation:0.00, brightness:0.93, alpha:0.00).cgColor
                
        self.font = UIFont(name: NOTO_SANS_REG, size: 20)
    }
}
