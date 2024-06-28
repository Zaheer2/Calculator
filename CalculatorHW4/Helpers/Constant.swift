//
//  Constant.swift
//  CalculatorHW4
//
//  Created by Fantom on 06.02.2022.
//

import UIKit

enum Constant {
    static let secondScreenButtonWidth: CGFloat = 200
    static let secondScreenButtonHeidth : CGFloat = 80
    static let secondScreenImageWidth: CGFloat = 120
    static let secondScreenImageButtomAnchor: CGFloat = 5
    static let answerScreenLabelHeightAnchor: CGFloat = 500
    static let pageControlWidth: CGFloat = 50
    static let pageControlButtonAnchor: CGFloat = 100
    static let secondRadius: CGFloat = UIScreen.fixedSmallSize * 0.3
    static let clockRadius: CGFloat = UIScreen.fixedSmallSize * 0.35
    static let smallCircleRadius: CGFloat = UIScreen.fixedSmallSize * 0.025
    static let smallCircleDiametr: CGFloat = smallCircleRadius * 2
    static let clockOffset: CGFloat = (UIScreen.fixedSmallSize - clockRadius * 2) / 2
    static let circleOffset: CGFloat = clockRadius - secondRadius
    static let clockNumberWidht: CGFloat = 50
    static let flipClockWidth: CGFloat =  UIScreen.fixedSmallSize * 0.7
    static let flipClockHeight: CGFloat =  UIScreen.fixedSmallSize * 0.3
    static let flipClockCornerRadius: CGFloat =  15
    static let flipClockButtomAnchor: CGFloat =  UIScreen.fixedSmallSize * 0.35
    static let flipClockNumberWidth: CGFloat =  flipClockWidth / 4.2
    static let flipClockNumberOffset: CGFloat =  flipClockNumberWidth * 0.1
    static let secondArrowWidth: CGFloat =  2
    static let secondArrowHeight: CGFloat =  Constant.secondRadius * 0.9
    static let minuteArrowWidth: CGFloat =  4
    static let minuteArrowHeight: CGFloat =  Constant.secondRadius * 0.8
    static let hourArrowWidth: CGFloat =  8
    static let hourArrowHeight: CGFloat =  Constant.secondRadius * 0.55
}

enum ScreenOrientation {
    case portrait
    case landscape
    
   static func getCurrentPosition(by traitCollection: UITraitCollection) -> ScreenOrientation {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            return .portrait
        }
        return .landscape
    }
}
