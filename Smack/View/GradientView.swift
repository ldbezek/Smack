//
//  GradientView.swift
//  Smack
//
//  Created by Luke Bezek on 10/19/20.
//

import UIKit

@IBDesignable //Makes it work in the storyboard
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) { //changes variables dynamically in the storyboard
        didSet { //Once we change it...
            self.setNeedsLayout() //Update our layout
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor] //Start and end color for gradient
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) //Start point for gradient aka upper left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) //End point for gradient aka lower right
        gradientLayer.frame = self.bounds //Sets gradient size to size of uiview
        self.layer.insertSublayer(gradientLayer, at: 0) //adding gradient layer to the uiviews layer, 0 is first layer
                
    }
    
}
