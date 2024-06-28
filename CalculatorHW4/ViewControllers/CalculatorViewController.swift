//
//  MainVIew.swift
//  CalculatorHW4
//
//  Created by Korsun Yevhenii on 08.05.2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    var calculatorView = CalculatorView()
    
    override func loadView() {
        view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        setStartingParameter()
#if DEBUG
        Singleton.shared.addTestData()
#endif
    }
    
    private func setButtons() {
        calculatorView.setButtonsActions(firstSelector: #selector(touchDownEvent(_:)), secondSelector: #selector(touchUpEvent(_:)))
    }
    
    func setStartingParameter() {
        let orientation: ScreenOrientation = UIScreen.size.width < UIScreen.size.height ? .portrait : .landscape
        calculatorView.setPatametersToScreenOrientation(screenOrientation: orientation)
    }
    
    @objc private func touchUpEvent(_ sender: CustomButton) { sender.touchUpEvent() }
    @objc private func touchDownEvent(_ sender: CustomButton) {
        sender.touchDownEvent()
        
        if isClearButton(in: sender.titleLabel?.text) { return }
        
        print("###\(sender.buttonTitle)")
        guard let symbol = sender.currentTitle else { return }
        guard let inputText = calculatorView.getInputLabelText() else { return }
        guard let lastChar = inputText.last else { return }
        guard let answerText = calculatorView.getAnswerLabelText() else { return }
        
        let typingController = TypingController(symbol: symbol, text: inputText, char: String(lastChar), lastAnswer: answerText)
        
        let newInputText = typingController.runControll().input
        calculatorView.setInputLabel(text: newInputText)
        let newAnswerText = typingController.runControll().answer
        calculatorView.setAnswerLabel(text: newAnswerText)
        
        if symbol == "=" { safeAnswer() }
        
        func safeAnswer() {
            let answerForSafe = typingController.runControll().answer
            let fullAnswer = Answer(formula: newInputText, answer: answerForSafe)
            
            Singleton.shared.answers.answersList.append(fullAnswer)
        }
    }
    
    private func isClearButton(in sender: String?) -> Bool {
        var answer = false
        if let buttonText = sender {
            if calculatorView.getClearButtonNames().contains(buttonText) {
                calculatorView.setInputLabel(text: "0")
                answer = true
            }
        }
        return answer
    }
}
