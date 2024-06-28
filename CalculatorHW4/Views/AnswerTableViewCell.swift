//
//  ToDoListTableViewCell.swift
//  CalculatorHW4
//
//  Created by Fantom on 15.02.2022.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    private lazy var formulaLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupAutoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupSubviews() {
        contentView.addSubview(formulaLabel)
        formulaLabel.numberOfLines = 0
    }
    
    private func setupAutoLayout() {
        formulaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formulaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            formulaLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            formulaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            formulaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    func setResult(answer: Answer){
        formulaLabel.text = "\(answer.formula) \(answer.answer)"
    }
}
