//
//  CustomButton.swift
//  CalculatorHW4
//
//  Created by Fantom on 08.02.2022.
//

import Foundation

import UIKit

class CustomButton: UIButton {
    
    enum ButtonColor {
        case purple
        case offWhite
        
        func getColor() -> CGColor {
            switch self {
            case .purple:
                return UIColor.customPurple.cgColor
            case .offWhite:
                return UIColor.offWhite.cgColor
            }
        }
    }
    
    let darkShadow = CALayer()
    let lightShadow = CALayer()
    let strokeGray = CALayer()
    let strokeWhite = CALayer()
    var buttonTitle: String

        required init(buttonTitle: String) {
            self.buttonTitle = buttonTitle
            
            super.init(frame: .zero)
  
            self.layer.cornerRadius = 15
            self.setTitle(buttonTitle, for: .normal)
        }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        darkShadow.frame = self.bounds
        lightShadow.frame = self.bounds
        addStroke()
    }
    
    func setShadowsAndColor(color: ButtonColor) {
        setShadow(layer: darkShadow, isBlack: true)
        setShadow(layer: lightShadow, isBlack: false)
        
        func setShadow(layer: CALayer, isBlack: Bool) {
            layer.cornerRadius = 15
            layer.backgroundColor = color.getColor()
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
    
    func addStroke() {
        setStroke(layer: strokeWhite, isWhite: true)
        setStroke(layer: strokeGray, isWhite: false)
        
        func setStroke(layer: CALayer, isWhite: Bool) {
            layer.frame = self.bounds
            layer.cornerRadius = 15
            layer.position.x += isWhite ? 2 : -2
            layer.position.y += isWhite ? 2 : -2
            self.layer.insertSublayer(layer, at: 1)
        }
    }
    
    func touchDownEvent() {
        strokeWhite.borderColor = UIColor.white.cgColor
        strokeWhite.borderWidth = 6
        strokeGray.borderColor = UIColor.gray.cgColor
        strokeGray.borderWidth = 6
        
        darkShadow.shadowOpacity = 0
        darkShadow.shadowOffset = CGSize(width: -5, height: -5)
        lightShadow.shadowOffset = CGSize(width: 10, height: 10)
        
        if let size = self.titleLabel?.font.pointSize {
            self.titleLabel?.font = UIFont.systemFont(ofSize:  (size / 1.2).rounded())
        }
    }
    
    func touchUpEvent() {
        strokeWhite.borderWidth = 0
        strokeGray.borderWidth = 0
        
        darkShadow.shadowOpacity = 1
        darkShadow.shadowOffset = CGSize(width: 10, height: 10)
        
        lightShadow.shadowOpacity = 1
        lightShadow.shadowOffset = CGSize(width: -5, height: -5)
        
        if let size = self.titleLabel?.font.pointSize {
            self.titleLabel?.font = UIFont.systemFont(ofSize:  (size * 1.2).rounded())
        }
    }
}
