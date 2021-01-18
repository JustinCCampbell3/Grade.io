//
//  GradientView.swift
//  HelloWorldv2
//
//  Created by Justin Campbell on 11/9/20.
//

import UIKit
@IBDesignable
class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = #colorLiteral(red: 0.9812352061, green: 0.6967955232, blue: 0.883050859, alpha: 1)
    @IBInspectable var secondColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var startPointX: CGFloat = 0
    var startPointY: CGFloat = 0
    var endPointX: CGFloat = 1
    var endPointY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
