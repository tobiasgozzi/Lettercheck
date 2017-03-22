//
//  LetterButton.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 26/01/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit


@IBDesignable
class LetterButton: UIButton {

    @IBInspectable var color: UIColor!
    
    let path: UIBezierPath! = nil
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor(hue:0.43, saturation:0.43, brightness:1.00, alpha:1.00).setFill()
        path.fill()
    }
    
    func toggleColor() {
        
        UIColor(hue:1.00, saturation:0.64, brightness:1.00, alpha:1.00).setFill()
        path.fill()
    }
    
    
    
}
