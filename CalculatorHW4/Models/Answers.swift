//
//  Answers.swift
//  CalculatorHW4
//
//  Created by Fantom on 13.02.2022.
//

import Foundation

struct Answer: Codable {
    let formula: String
    let answer: String
}

struct Answers: Codable {
    var answersList: [Answer] = []
}
