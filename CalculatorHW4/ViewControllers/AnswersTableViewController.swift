//
//  AnswersViewController.swift
//  CalculatorHW4
//
//  Created by Fantom on 11.02.2022.
//

import UIKit

class AnswersTableViewController: UIViewController {
    
    private lazy var tableView: UITableView = UITableView()
    
    struct Cell {
        static let answerCell = "answerTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .offWhite
        setTableView()
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.backgroundColor = .offWhite
        navigationController?.navigationBar.barTintColor = .offWhite
        tabBarController?.tabBar.barTintColor = .offWhite
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: Cell.answerCell)
        tableView.backgroundColor = .offWhite
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.sectionHeaderTopPadding = .zero
    }
    
    private func filterAnswers(symbol: String, answers: Answers) -> Answers {
        var newAnswers = Answers()
        for i in answers.answersList {
            if i.formula.contains(symbol) {
                newAnswers.answersList.append(i)
            }
        }
        return newAnswers
    }
}

extension AnswersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Header.elements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let answers = Singleton.shared.answers
        var rowCount = 0
        let symbol =  Header.elements[section].symbol
        rowCount = filterAnswers(symbol: symbol, answers: answers).answersList.count
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.answerCell, for: indexPath) as? AnswerTableViewCell else { return UITableViewCell() }
        
        let backgroundColorView = UIView()
        let answers = Singleton.shared.answers
        let sectionNumber = indexPath.section
        let answerInCurrentSection = filterAnswers(symbol: Header.elements[sectionNumber].symbol, answers: answers).answersList[indexPath.row]
        
        backgroundColorView.backgroundColor = UIColor.customPurple.withAlphaComponent(0.4)
        cell.selectedBackgroundView = backgroundColorView
        cell.backgroundColor = .offWhite
        cell.setResult(answer: answerInCurrentSection)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return Header.height
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .offWhite
        
        let baseView = CustomButton(buttonTitle: "")
        baseView.setShadowsAndColor(color: .offWhite)
        baseView.frame = Header.baseFrame
        headerView.addSubview(baseView)
        
        let sectionHeaderImage = UIImage(systemName: Header.elements[section].image)
        let sectionHeaderImageView = UIImageView(image: sectionHeaderImage)
        sectionHeaderImageView.frame = Header.imageFrame
        sectionHeaderImageView.tintColor = .gray
        headerView.addSubview(sectionHeaderImageView)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.text = Header.elements[section].name
        sectionHeaderLabel.textColor = .gray
        sectionHeaderLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        sectionHeaderLabel.frame = Header.labelFrame
        headerView.addSubview(sectionHeaderLabel)
        
        return headerView
    }
}
