//
//  SecondViewController.swift
//  CalculatorHW4
//
//  Created by Fantom on 10.02.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    private lazy var button: CustomButton = {
        let button = CustomButton(buttonTitle: "Get last answer")
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(touchDownEvent(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(touchUpEvent(_:)), for: [.touchUpInside, .touchUpOutside])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    private lazy var image = UIImage(systemName: "info.circle")
    private lazy var imageView = UIImageView(image: image!)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .offWhite
        view.addSubview(button)
        setImage()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        button.setShadowsAndColor(color: .offWhite)
    }
    
    func setImage(){
        if let myImage = image {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .customPurple
            imageView.image = tintableImage
        }
        view.addSubview(imageView)
    }
    func setConstraints(){
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: Constant.secondScreenButtonWidth),
            button.heightAnchor.constraint(equalToConstant: Constant.secondScreenButtonHeidth),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -Constant.secondScreenImageButtomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constant.secondScreenImageWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constant.secondScreenImageWidth)
        ])
    }
    
    @objc private func touchDownEvent(_ sender: CustomButton) {
        sender.touchDownEvent()
    }
    @objc private func touchUpEvent(_ sender: CustomButton) {
        sender.touchUpEvent()
        let pageViewController = PageViewController()
        
        navigationController?.pushViewController(pageViewController, animated: true)
    }
}
