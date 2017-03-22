//
//  RedDot.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 21/12/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
class RedDot: UIView {


    @IBInspectable var color: UIColor!
    
    let path: UIBezierPath! = nil
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor(hue:0.43, saturation:0.43, brightness:1.00, alpha:1.00).setFill()
        path.fill()
    }
    
    func setRed() {
        
        UIColor(hue:1.00, saturation:0.64, brightness:1.00, alpha:1.00).setFill()
        path.fill()
    }
    
}
