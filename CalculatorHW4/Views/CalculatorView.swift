//
//  MainVIew.swift
//  CalculatorHW4
//
//  Created by Korsun Yevhenii on 08.05.2022.
//

import UIKit

class CalculatorView: UIView {
    private let viewModel = ViewModel()
    private var allButtons: [UIButton] = []
    private var inputLabel: UILabel = UILabel()
    private var answerLabel: UILabel = UILabel()
    
    private lazy var canselButtonIndex: Int? = {
        var cancelIndex: Int?
        for index in allButtons.indices {
            if let text = allButtons[index].titleLabel?.text,
               getClearButtonNames().contains(text) {
                cancelIndex = index
                break
            }
        }
        return cancelIndex
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setPatametersToScreenOrientation(screenOrientation: ScreenOrientation.getCurrentPosition(by: traitCollection))
    }
    
    // MARK: - External parameters methods:
    func setPatametersToScreenOrientation(screenOrientation: ScreenOrientation) {
        if let index = canselButtonIndex { allButtons[index].setTitle("AC", for: .normal) }
        for button in allButtons { button.removeFromSuperview() }
        
        let spacer = viewModel.spacer
        let isInPortrait = screenOrientation == .portrait
        let window = UIApplication.shared.windows.first
        let bottomPadding: CGFloat = window?.safeAreaInsets.bottom ?? .zero
        let currentStruct: [[String]] = viewModel.getButtonsStruct(basedOn: screenOrientation)
        let buttonHeight = viewModel.getButtonsHeight(basedOn: screenOrientation)
        let buttonWidth = viewModel.getButtonsWidth(basedOn: screenOrientation)
        let xOffset: CGFloat = viewModel.getXOffset(basedOn: screenOrientation)
        let yOffset: CGFloat = viewModel.getYOffset(basedOn: screenOrientation, bottomPadding: bottomPadding)
        
        let bigButtonModule: CGFloat = buttonWidth + spacer
        var stackCount: CGFloat = 0
        var rowCount: CGFloat = 0
        var bigButtonMultiplier: CGFloat = 0
        var bigButtonSpacerMultiplier: CGFloat = 0
        
        for row in currentStruct {
            for buttonName in row {
                if let i = allButtons.firstIndex(where: { $0.currentTitle == buttonName }) {
                    bigButtonMultiplier = viewModel.bigButtonsName.contains(buttonName) ? 1 : 0
                    
                    frame = CGRect(x: xOffset + (stackCount + bigButtonSpacerMultiplier) * (buttonWidth + spacer),
                                   y: yOffset + rowCount * (buttonHeight + spacer),
                                   width: buttonWidth + bigButtonModule * bigButtonMultiplier,
                                   height: buttonHeight)
                    
                    allButtons[i].frame = frame
                    allButtons[i].titleLabel?.font = viewModel.setButtonFont(basedOn: screenOrientation)
                    self.addSubview(allButtons[i])
                }
                stackCount += 1
                if bigButtonMultiplier == 1 { bigButtonSpacerMultiplier += 1 }
            }
            stackCount = 0
            rowCount += 1
            bigButtonSpacerMultiplier = 0
        }
        
        let buttonCountInRow: CGFloat = CGFloat(currentStruct[0].count)
        inputLabel.frame = CGRect(x: xOffset,
                                  y: yOffset - buttonHeight - spacer,
                                  width: (buttonWidth * buttonCountInRow) + (spacer * (buttonCountInRow - 1)),
                                  height: buttonHeight)
        answerLabel.frame  = CGRect(x: xOffset,
                                    y: yOffset - buttonHeight * 1.7 - spacer,
                                    width: (buttonWidth * buttonCountInRow) + (spacer * (buttonCountInRow - 1)),
                                    height: buttonHeight)
        
        inputLabel.font = inputLabel.font.withSize(isInPortrait ? 24 : 30)
        answerLabel.font = answerLabel.font.withSize(isInPortrait ? 36 : 40)
        setClearButton()
    }
    
    func setButtonsActions(firstSelector: Selector, secondSelector: Selector) {
        allButtons.forEach { element in
            element.addTarget(firstSelector, action: firstSelector, for: .touchDown)
            element.addTarget(secondSelector, action: secondSelector, for: [.touchUpInside, .touchUpOutside])
        }
    }
    
    func setInputLabel(text: String) {
        inputLabel.text = text
        setClearButton()
    }
    
    func getInputLabelText() -> String? { inputLabel.text }
    func setAnswerLabel(text: String) { answerLabel.text = text }
    func getAnswerLabelText() -> String? { answerLabel.text }
    func getClearButtonNames() -> [String] { viewModel.clearButtonNames }
    
    // MARK: - Helpers methods:
    private func createSubviews() {
        setGradientLayer()
        createButtons()
        setLabels()
    }
    
    private func setGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.grabientBackgrounTopColor.cgColor, UIColor.grabientBackgrounButtomColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.fixedBigSize, height: UIScreen.fixedBigSize)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func createButtons() {
        for name in viewModel.allButtonsName {
            let button = CustomButton(buttonTitle: name)
            button.setShadowsAndColor(color: viewModel.colorButtonsName.contains(name) ? .purple : .offWhite)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize:  30)
            allButtons.append(button)
        }
    }
    
    private func setLabels() {
        inputLabel.setLabel(numberOfLines: 2, text: "0")
        answerLabel.setLabel(numberOfLines: 1, text: "")
        self.addSubview(inputLabel)
        self.addSubview(answerLabel)
    }
    
    private func setClearButton() {
        guard let index = canselButtonIndex else { return }
        
        if  inputLabel.text == "0" {
            allButtons[index].setTitle("AC", for: .normal)
            allButtons[index].setTitleColor(.gray, for: .normal)
        } else {
            allButtons[index].setTitle("C", for: .normal)
            allButtons[index].setTitleColor(.red.withAlphaComponent(0.4), for: .normal)
        }
    }
}

fileprivate extension UILabel {
    func setLabel(numberOfLines: Int, text: String) {
        self.textAlignment = .right
        self.textColor = .gray
        self.minimumScaleFactor = 0.7
        self.adjustsFontSizeToFitWidth = true
        self.sizeToFit()
        self.numberOfLines = numberOfLines
        self.text = text
    }
}
