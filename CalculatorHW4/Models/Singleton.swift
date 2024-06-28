//
//  Singleton.swift
//  CalculatorHW4
//
//  Created by Fantom on 11.02.2022.
//

import UIKit

class Singleton {
    var answers: Answers = Answers()
    static let shared = Singleton()
}

