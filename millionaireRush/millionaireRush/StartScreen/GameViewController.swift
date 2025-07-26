//
//  GameViewController.swift
//  millionaireRush
//
//  Created by Alexander Ischenko on 24.07.2025.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "call"), for: .normal)
        button.addTarget(self, action: #selector(pressedSecondaryButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var timerView: StopwatchView = {
        let timer = StopwatchView()
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    private lazy var audienceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "audience"), for: .normal)
        button.addTarget(self, action: #selector(pressedSecondaryButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var fiftyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "50_50"), for: .normal)
        button.addTarget(self, action: #selector(pressedSecondaryButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var firstAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.addTarget(self, action: #selector(pressedAnswerButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.addTarget(self, action: #selector(pressedAnswerButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var thirdAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.addTarget(self, action: #selector(pressedAnswerButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var fourthAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.addTarget(self, action: #selector(pressedAnswerButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "hello millionare"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"arrow_back"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var barChartButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"bar chart"), for: .normal)
        button.addTarget(self, action: #selector(openResult), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isContunueGame: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [backgroundImageView, callButton, timerView, audienceButton, fiftyButton, firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, questionLabel, returnButton, barChartButton].forEach( {view.addSubview($0) } )
        timerView.onFinish = {  [weak self] in
            self?.questionLabel.text = "Game over! Time is up"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self?.openEndGame()
            }
        }
        setupConstraints()
        setupGame()
    }
    
    private func setupGame() {
        if !isContunueGame {
            currentQuestionIndex = 0
        }
        showQuestion()
    }

    private func showQuestion() {
        timerView.start()
        guard currentQuestionIndex < questions!.count else {
                questionLabel.text = "Congratulations! You've finished the game!"
                [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].forEach { $0.isHidden = true }
                return
            }
        let question = questions![currentQuestionIndex]
            questionLabel.text = question.question.removingHTMLEntities()
            let allAnswers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
            firstAnswerButton.setTitle(allAnswers[0], for: .normal)
            secondAnswerButton.setTitle(allAnswers[1], for: .normal)
            thirdAnswerButton.setTitle(allAnswers[2], for: .normal)
            fourthAnswerButton.setTitle(allAnswers[3], for: .normal)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            callButton.heightAnchor.constraint(equalToConstant: 64),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37.5),
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 84),
            fiftyButton.heightAnchor.constraint(equalToConstant: 64),
            fiftyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            fiftyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37.5),
            audienceButton.heightAnchor.constraint(equalToConstant: 64),
            audienceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            audienceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthAnswerButton.heightAnchor.constraint(equalToConstant: 56),
            fourthAnswerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -164),
            fourthAnswerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            fourthAnswerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            thirdAnswerButton.heightAnchor.constraint(equalToConstant: 56),
            thirdAnswerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            thirdAnswerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            thirdAnswerButton.bottomAnchor.constraint(equalTo: fourthAnswerButton.topAnchor, constant: -16),
            secondAnswerButton.heightAnchor.constraint(equalToConstant: 56),
            secondAnswerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            secondAnswerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            secondAnswerButton.bottomAnchor.constraint(equalTo: thirdAnswerButton.topAnchor, constant: -16),
            firstAnswerButton.heightAnchor.constraint(equalToConstant: 56),
            firstAnswerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            firstAnswerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            firstAnswerButton.bottomAnchor.constraint(equalTo: secondAnswerButton.topAnchor, constant: -16),
            questionLabel.heightAnchor.constraint(equalToConstant: 147),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            questionLabel.bottomAnchor.constraint(equalTo: firstAnswerButton.topAnchor, constant: -32),
            returnButton.heightAnchor.constraint(equalToConstant: 32),
            returnButton.widthAnchor.constraint(equalToConstant: 32),
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            barChartButton.heightAnchor.constraint(equalToConstant: 32),
            barChartButton.widthAnchor.constraint(equalToConstant: 32),
            barChartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            barChartButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
        ])
    }
    
    @objc func pressedAnswerButton(_ sender: UIButton) {
        guard currentQuestionIndex < questions!.count else { return }

        let selectedAnswer = sender.title(for: .normal)
        let correctAnswer = questions![currentQuestionIndex].correctAnswer

        if selectedAnswer == correctAnswer {
            sender.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                [self.firstAnswerButton, self.secondAnswerButton, self.thirdAnswerButton, self.fourthAnswerButton].forEach {
                    $0.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
                }
                currentQuestionIndex += 1
                self.showQuestion()
            }
        } else {
            sender.setBackgroundImage(UIImage(named: "redButton"), for: .normal)
            [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].forEach {
                $0.isUserInteractionEnabled = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.timerView.pause()
                self.openEndGame()
            }
            [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].first {
                $0.title(for: .normal) == correctAnswer
            }?.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
        }
    }
    
    @objc func pressedSecondaryButton(_ sender: UIButton) {
        
        sender.isEnabled = false
        sender.alpha = 0.5
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
    
    func openEndGame() {
        let endVC = EndScreenVC()
        endVC.modalPresentationStyle = .fullScreen
        present(endVC, animated: true)
    }
    
    @objc func openResult() {
        let resultVC = ResultViewController()
        resultVC.selectedLevel = currentQuestionIndex
        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true)
    }
}
