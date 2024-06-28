//
//  AnswerTableViewHeader.swift
//  CalculatorHW4
//
//  Created by Fantom on 15.02.2022.
//

import UIKit

class AnswerTableViewHeader: UIView {

    
    private lazy var headerNameLabel: UILabel = UILabel()
    
    required init() {
            super.init(frame: .zero)
            // Setting up the view can be done here

        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    private func setupSubviews(){
        contentView.addSubview(headerNameLabel)
   //     contentView.addSubview(answerLabel)
    }
    
    private func setupLabels(){
        headerNameLabel.numberOfLines =
    }
    
    private func setupAutoLayout() {
       
        ])
    }
    
    func setResult(answer: Answer){
//        formulaLabel.text = answer.formula
//        answerLabel.text = "=\(answer.answer)"
    }
}
