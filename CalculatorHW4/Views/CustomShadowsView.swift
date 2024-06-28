//
//  CustomShadows.swift
//  CalculatorHW4
//
//  Created by Fantom on 21.02.2022.
//

import UIKit

class CustomShadowsView: UIView {
    let darkShadow = CALayer()
    let lightShadow = CALayer()
    let strokeGray = CALayer()
    let strokeWhite = CALayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        darkShadow.frame = self.bounds
        lightShadow.frame = self.bounds
    }
    
    func setShadowsAndColor(color: UIColor, cornerRadius: CGFloat) {
        print("setNew shadows")
        setShadow(layer: darkShadow, isBlack: true)
        setShadow(layer: lightShadow, isBlack: false)
        
        func setShadow(layer: CALayer, isBlack: Bool) {
            layer.cornerRadius = cornerRadius
            layer.backgroundColor = color.cgColor
            layer.shadowOpacity = 1
            layer.shadowRadius = 15
            layer.shouldRasterize = true
            self.layer.insertSublayer(layer, at: 0)
            if isBlack{
                darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
                darkShadow.shadowOffset = CGSize(width: 10, height: 10)
            } else {
                lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.7).cgColor
                lightShadow.shadowOffset = CGSize(width: -5, height: -5)
            }
        }
    }
}
