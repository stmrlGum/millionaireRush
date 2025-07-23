//
//  StartScreenVC.swift
//  millionaireRush
//
//  Created by Danil on 21.07.2025.
//

import UIKit
import Foundation

enum HomeScreenState {
    case firstStart
    case gameInProgress
    case noGameWithHighScore
}

class StartScreenVC: UIViewController {
    
    
    var bestScore: Int = 15000 // MARK: TEMP HARDCODE
    var hasSavedGame: Bool = true
    
    var currentState: HomeScreenState {
        if hasSavedGame {
            return .gameInProgress
        } else if bestScore > 0 {
            return .noGameWithHighScore
        } else {
            return .firstStart
        }
    }
    
   //MARK: UI Элементы
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let scoreLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 2
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("New game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedStartButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Who Wants\n to be a Millionare"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoMillionare: UIImageView = {
        let logoImageView = UIImageView()
        let image = UIImage(named: "logo")
        logoImageView.image = image
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.clipsToBounds = true
        return logoImageView
    }()
    
    private lazy var helpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedHelpButton), for: .touchUpInside)
        return button
    }()
        
    private lazy var allTimeScoreTextLabel: UILabel = {
        let label = UILabel()
        label.text = "All-time Best Score"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = false
        return label
    }()
    
    private lazy var allTimeScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "$\(bestScore)"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.addTarget(self, action: #selector(pressedContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var coinImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "coin")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [backgroundImageView, startButton, textLabel, logoMillionare, helpButton,continueButton, allTimeScoreLabel, allTimeScoreTextLabel, scoreLabelStack].forEach( {view.addSubview($0) })
        scoreLabelStack.addArrangedSubview(coinImage)
        scoreLabelStack.addArrangedSubview(allTimeScoreLabel)
        setupConstaints()
        updateUI(for: currentState)
    }
    
    //MARK: Private Methods
    private func setupConstaints(){
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 62),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -109),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            textLabel.heightAnchor.constraint(equalToConstant: 76),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            textLabel.bottomAnchor.constraint(equalTo: allTimeScoreTextLabel.topAnchor, constant: -16),
            logoMillionare.heightAnchor.constraint(equalToConstant: 250),
            logoMillionare.widthAnchor.constraint(equalToConstant: 250),
            logoMillionare.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            logoMillionare.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            logoMillionare.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -16),
            helpButton.heightAnchor.constraint(equalToConstant: 32),
            helpButton.widthAnchor.constraint(equalToConstant: 32),
            helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            helpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            continueButton.heightAnchor.constraint(equalToConstant: 62),
            continueButton.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -16),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
//            allTimeScoreLabel.heightAnchor.constraint(equalToConstant: 32),
//            allTimeScoreLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -78),
//            allTimeScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//            allTimeScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            allTimeScoreTextLabel.heightAnchor.constraint(equalToConstant: 19),
            allTimeScoreTextLabel.bottomAnchor.constraint(equalTo: scoreLabelStack.topAnchor, constant: -8),
            allTimeScoreTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            allTimeScoreTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            scoreLabelStack.heightAnchor.constraint(equalToConstant: 32),
            scoreLabelStack.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -78),
            scoreLabelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            scoreLabelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
            coinImage.heightAnchor.constraint(equalToConstant: 32),
            coinImage.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func updateUI(for state: HomeScreenState) {
        
        switch state {
        case .firstStart:
            allTimeScoreLabel.isHidden = true
            allTimeScoreTextLabel.isHidden = true
            continueButton.isHidden = true
            startButton.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
            NSLayoutConstraint.activate([
                textLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -147)
            ])
            
        case .gameInProgress:
            startButton.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
            
        case .noGameWithHighScore:
            continueButton.isHidden = true
            NSLayoutConstraint.activate([
                allTimeScoreLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -111)
            ])
        }
    }
    
    private func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
                UIColor(red: 55/255, green: 76/255, blue: 148/255, alpha: 1).cgColor,
                UIColor(red: 16/255, green: 14/255, blue: 2/255, alpha: 1).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.frame = view.bounds

            view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func pressedStartButton(_ sender: UIButton) {
        sender.changeState()
        print("New game")
    }
    
    @objc func pressedContinueButton(_ sender: UIButton) {
        sender.changeState()
        print("Continue game")
    }
    
    @objc func pressedHelpButton(_ sender: UIButton) {
        print("help is help")
    }
}
  

