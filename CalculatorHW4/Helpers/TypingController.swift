//
//  TypingControll.swift
//  CalculatorHW4
//
//  Created by Fantom on 10.02.2022.
//

import Foundation

class TypingController {
    
    let symbol: String
    let text: String
    let char: String
    let lastAnswer: String
    
    init(symbol: String, text: String, char: String, lastAnswer: String) {
        self.symbol = symbol
        self.text = text
        self.char = char
        self.lastAnswer = lastAnswer
    }
    
    func runControll() -> (input: String, answer: String){
        var input = text
        var answer = lastAnswer
        let operators = ["+", "-", "*", "/", "^", "(" ]
        
        if !answer.isEmpty {
            input = "0"
            answer = ""
        }
        
        switch symbol {
        case "(", ")" :
            BracketTyping(current: symbol, typed: input, last: char)
        case ".":
            dotTyping(current: symbol, typed: input, last: char)
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            numberTyping(current: symbol, typed: input, last: char)
        case "+", "-", "*", "/", "^":
            operatorsTyping(current: symbol, typed: input, last: char)
        case "←":
            backSpaceTyping(current: symbol, typed: input, last: char)
        case "=":
            equalTyping(current: symbol, typed: input, last: char)
        case "C":
            cancelTyping()
        default: break
        }
        
        // MARK: - Mathematics Methods
        
        func BracketTyping(current symbol: String, typed text: String, last char: String) {
            if symbol == ")"{
                if symbol == ")" && unclosedBracketsNum(text) > 0 && !operators.contains(char) {
                    addTypingSymbol(symbol)
                }
            }
            
            if text == "0" &&  symbol != ")" {
                clearTextTyping()
                addTypingSymbol(symbol)
                
            } else if operators.contains(char) &&  symbol != ")" {
                addTypingSymbol(symbol)
                
            } else { return }
            clearAnswer()
        }
        
        func dotTyping(current symbol: String, typed text: String, last char: String) {
            if operators.contains(char){
                addTypingSymbol("0\(symbol)")
            } else if !isDot(text) {
                addTypingSymbol(symbol)
            } else { return }
            
            func isDot(_ text: String) -> Bool {
                var result = false
                let operators = operators + [")"]
                
                for i in text.reversed() {
                    if String(i) == "." {
                        result = true
                        break
                    } else if operators.contains(String(i)) {
                        result = false
                        break
                    }
                }
                return result
            }
        }
        
        func numberTyping(current symbol: String, typed text: String, last char: String) {
            if text == "0" {
                clearTextTyping()
                addTypingSymbol(symbol)
                
            } else if char != ")" {
                addTypingSymbol(symbol)
            } else { return }
        }
        
        func operatorsTyping(current symbol: String, typed text: String, last char: String) {
            let operators = operators + ["."]
            
            if !operators.contains(char) {
                if text == "0" && char == "-" {
                    clearTextTyping()
                    addTypingSymbol(symbol)
                } else { addTypingSymbol(symbol) }
            } else if char == "(" && symbol == "-" {
                addTypingSymbol(symbol)
            } else { return }
        }
        
        func backSpaceTyping(current symbol: String, typed text: String, last char: String) {
            if text.count == 1 {
                input = "0"
            } else {
                input.removeLast()
            }
        }
        
        func equalTyping(current symbol: String, typed text: String, last char: String) {
            let operators = operators + ["."]
            
            if operators.contains(char) { input.removeLast() }
            for _ in 0..<unclosedBracketsNum(text) {
                addTypingSymbol(")")
            }
            
            let counter = Counter(formula: input)
            let result = counter.count()
            answer = "= \(String(format: "%.10g",result))"
        }
        
        func unclosedBracketsNum(_ text: String) -> Int {
            var result = 0
            
            for i in text {
                if String(i) == "(" {
                    result += 1
                } else if String(i) == ")" {
                    result -= 1
                }
            }
            return result
        }
        
        func cancelTyping() { input = "0" }
        func clearAnswer() { answer = "" }
        func addTypingSymbol(_ string: String) { input += string }
        func clearTextTyping() { input = "" }
        
        return (input, answer)
    }
}
