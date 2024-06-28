//
//  AnswersTestData.swift
//  CalculatorHW4
//
//  Created by Fantom on 16.02.2022.
//

import Foundation

extension Singleton{
    func addTestData(){
    answers.answersList.append(Answer(formula: "22+33", answer: "= 55"))
    answers.answersList.append(Answer(formula: "99-8*10", answer: "= 19"))
    answers.answersList.append(Answer(formula: "999", answer: "= 999"))
    answers.answersList.append(Answer(formula: "99999999-99999999", answer: "= 0"))
    answers.answersList.append(Answer(formula: "2^2-6", answer: "= -2"))
    answers.answersList.append(Answer(formula: "99/9+3*6", answer: "= 28"))
    }
}
