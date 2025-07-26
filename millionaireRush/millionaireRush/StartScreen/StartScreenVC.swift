//
//  StartScreenVC.swift
//  millionaireRush
//
//  Created by Danil on 21.07.2025.
//

import UIKit
import Foundation

var questions: [QuestionVM]?
var currentQuestionIndex = 0

enum StartScreenState {
    case firstStart
    case gameInProgress
    case noGameWithHighScore
}

class StartScreenVC: UIViewController {
    
    
    var bestScore: Int = 15000 // MARK: TEMP HARDCODE
    var hasSavedGame: Bool = true
    
    var currentState: StartScreenState {
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
    
    private lazy var rulesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedRulesButton), for: .touchUpInside)
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
        [backgroundImageView, startButton, textLabel, logoMillionare, rulesButton,continueButton, allTimeScoreLabel, allTimeScoreTextLabel, scoreLabelStack].forEach( {view.addSubview($0) })
        scoreLabelStack.addArrangedSubview(coinImage)
        scoreLabelStack.addArrangedSubview(allTimeScoreLabel)
        setupConstaints()
        updateUI(for: currentState)
    }
    
    //MARK: Private Methods
    private func setupConstaints(){
        NSLayoutConstraint.activate([
            //            allTimeScoreLabel.heightAnchor.constraint(equalToConstant: 32),
            //            allTimeScoreLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -78),
            //            allTimeScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            //            allTimeScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
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
            logoMillionare.heightAnchor.constraint(equalToConstant: 195),
            logoMillionare.widthAnchor.constraint(equalToConstant: 195),
            logoMillionare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoMillionare.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -16),
            rulesButton.heightAnchor.constraint(equalToConstant: 32),
            rulesButton.widthAnchor.constraint(equalToConstant: 32),
            rulesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rulesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            continueButton.heightAnchor.constraint(equalToConstant: 62),
            continueButton.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -10),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
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
    
    private func updateUI(for state: StartScreenState) {
        
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
    
    @objc func pressedStartButton(_ sender: UIButton) {
        sender.changeState()
        sender.isUserInteractionEnabled = false
        NetworkManager.shared.getData { [weak self] result in
            switch result {
            case .success(let json):
                let question = MillionareVM(json: json)
                questions = question.results
                    DispatchQueue.main.async {
                        self?.openGame(isContinue: false)
                        sender.isUserInteractionEnabled = true
                    }
            case .failure(let error):
                debugPrint("Ошибка при получении данных: \(error)")
            }
        }
    }
    
    @objc func pressedContinueButton(_ sender: UIButton) {
        sender.changeState()
        openGame(isContinue: true)
    }
    
    @objc func pressedRulesButton(_ sender: UIButton) {
        let rules = RulesViewController()
        let navController = UINavigationController(rootViewController: rules)
        present(navController, animated: true, completion: nil)
    }
    
    func openGame(isContinue: Bool) {
        let gameVC = GameViewController()
        gameVC.isContunueGame = isContinue
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true)
    }
}
  

