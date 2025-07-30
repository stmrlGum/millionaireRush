//
//  RulesViewController.swift
//  millionaireRush
//
//  Created by Ilnur on 25.07.2025.
//

import UIKit


class RulesViewController: UIViewController {
    
    let viewModel = RulesViewModel(rulesService: RulesService())
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.backgroundColor = #colorLiteral(red: 0.250951618, green: 0.2677560449, blue: 0.3410356045, alpha: 1)
        textView.textContainerInset = .init(top: 0, left: 30, bottom: 0, right: 30)
        textView.textAlignment = .left
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.250951618, green: 0.2677560449, blue: 0.3410356045, alpha: 1)
        view.addSubview(textView)
        setupTextContent()
        setupConstraints()
        setupCloseButton()
        title = "Rules"
        
        if let navBar = navigationController?.navigationBar {
                navBar.setBackgroundImage(UIImage(), for: .default)
                navBar.shadowImage = UIImage()
                navBar.isTranslucent = true
                navBar.backgroundColor = .clear
                
                navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBar.tintColor = .white
            }
    }
    
    
    func setupTextContent() {
        textView.text = viewModel.ruleText.content
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    
    func setupCloseButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

