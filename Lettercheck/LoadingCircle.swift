//
//  LoadingCircle.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 08/02/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit
import CoreGraphics


@IBDesignable
class LoadingCircle: UIView {

    var startAngle: CGFloat = 0.0
    var endAngle: CGFloat = 0.0
    var toggle = true
    
    var path: UIBezierPath?
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
     
        path = UIBezierPath(arcCenter: CGPoint(x: rect.midX,y: rect.midY), radius: rect.width/3, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)

        UIColor(hue:0.43, saturation:0.43, brightness:1.00, alpha:1.00).setStroke()
        path?.lineWidth = 5
        path?.stroke()
        
    }
    
    func rot() {
        if path != nil {
            
            
            move()
//            let rotation = CGAffineTransform(rotationAngle: CGFloat(count))
//            path!.apply(rotation)
            
//            self.transform = rotation
            
            
              //rotating the circle
//            if startAngle < 6.28 {
//                startAngle += 0.01
//            } else {
//                startAngle = 0
//            }
//                
//                
//            if endAngle < 6.28 {
//                endAngle += 0.01
//            } else {
//                endAngle = 0
//            }
            
            self.setNeedsDisplay()
            
        }
    }

    private func move(){
        if(toggle == true) {
            if startAngle != 0.0 {
                startAngle = 0.0
            }
            endAngle += 0.01
        } else {
            if endAngle != 0.0 {
                endAngle = 0.0
            }
            startAngle += 0.01
        }
        if endAngle >= 6.28 {
            toggle = false
        } else if startAngle >= 6.28 {
            toggle = true
        }
    }
    
}
