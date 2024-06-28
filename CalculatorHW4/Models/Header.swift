//
//  Header.swift
//  CalculatorHW4
//
//  Created by Fantom on 16.02.2022.
//

import UIKit

struct Header: Codable {
    let name: String
    let symbol: String
    let image: String
}

extension Header {
    static let elements = [
    Header(name: "Addition", symbol: "+", image: "plus.circle"),
    Header(name: "Subtraction", symbol: "-", image: "minus.circle"),
    Header(name: "Multiplication", symbol: "*", image: "multiply.circle"),
    Header(name: "Division", symbol: "/", image: "divide.circle"),
    Header(name: "Exponentiation", symbol: "^", image: "chevron.up.circle"),
    ]
    
    static let height = CGFloat(50)
    static let baseFrame = CGRect(x: 10, y: 0, width: UIScreen.fixedSmallSize * 0.9, height: height)
    static let imageFrame = CGRect(x: 13, y: 10, width: 30, height: 30)
    static let labelFrame = CGRect(x: 53, y: 5, width: 250, height: 40)
}

