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
        button.addTarget(self, action: #selector(callHint), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(audienceHint), for: .touchUpInside)
        return button
    }()
    
    private lazy var fiftyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "50_50"), for: .normal)
        button.addTarget(self, action: #selector(fiftyHint), for: .touchUpInside)
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
    
    private lazy var numberOfQuestion: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "QUESTION #1"
        label.textColor = .white
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "$500"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var isContunueGame: Bool = false
    
    let levels: [(number: Int, prize: String)] = [
        (15, "$1,000,000"),
        (14, "$500,000"),
        (13, "$250,000"),
        (12, "$100,000"),
        (11, "$50,000"),
        (10, "$25,000"),
        (9, "$15,000"),
        (8, "$12,500"),
        (7, "$10,000"),
        (6, "$7,500"),
        (5, "$5,000"),
        (4, "$3,000"),
        (3, "$2,000"),
        (2, "$1,000"),
        (1, "$500")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [backgroundImageView, numberOfQuestion, costLabel, callButton, timerView, audienceButton, fiftyButton, firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, questionLabel, returnButton, barChartButton].forEach( {view.addSubview($0) } )
        timerView.onFinish = {  [weak self] in
            self?.questionLabel.text = "Game over! Time is up"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self?.openEndGame()
            }
        }
        setupConstraints()
        setupGame()
        SoundManager.shared.playSound(sound: .clock)
    }
    
    private func setupGame() {
        if !isContunueGame {
            currentQuestionIndex = 0
        }
        showQuestion()
    }

    private func showQuestion() {
        timerView.start()
        
        [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].forEach { button in
            button.isHidden = false
            button.isEnabled = true
            button.alpha = 1.0
        }
        
        if let level = levels.first(where: { $0.number == currentQuestionIndex! + 1 }) {
            numberOfQuestion.text = "QUESTION #\(level.number)"
            costLabel.text = level.prize
        }
        
        guard currentQuestionIndex! < questions!.count else {
            questionLabel.text = "Congratulations! You've finished the game!"
            self.timerView.pause()
            SoundManager.shared.playSound(sound: .correctAnswer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.openEndGame()
            }
            [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].forEach { $0.isHidden = true }
            return
        }
        let question = questions![currentQuestionIndex!]
            questionLabel.text = question.question.removingHTMLEntities()
            let allAnswers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
            firstAnswerButton.setTitle(allAnswers[0].removingHTMLEntities(), for: .normal)
            secondAnswerButton.setTitle(allAnswers[1].removingHTMLEntities(), for: .normal)
            thirdAnswerButton.setTitle(allAnswers[2].removingHTMLEntities(), for: .normal)
            fourthAnswerButton.setTitle(allAnswers[3].removingHTMLEntities(), for: .normal)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            numberOfQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberOfQuestion.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            numberOfQuestion.heightAnchor.constraint(equalToConstant: 19),
            costLabel.topAnchor.constraint(equalTo: numberOfQuestion.bottomAnchor, constant: 0),
            costLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            costLabel.heightAnchor.constraint(equalToConstant: 21),
            callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            callButton.heightAnchor.constraint(equalToConstant: 64),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37.5),
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 32),
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
        guard currentQuestionIndex! < questions!.count else { return }

        let selectedAnswer = sender.title(for: .normal)
        let correctAnswer = questions![currentQuestionIndex!].correctAnswer

        if selectedAnswer == correctAnswer {
            sender.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
            SoundManager.shared.playSound(sound: .correctAnswer)
            self.timerView.pause()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                [self.firstAnswerButton, self.secondAnswerButton, self.thirdAnswerButton, self.fourthAnswerButton].forEach {
                    $0.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
                }
                SoundManager.shared.playSound(sound: .clock)
                currentQuestionIndex! += 1
                self.showQuestion()
            }
        } else {
            sender.setBackgroundImage(UIImage(named: "redButton"), for: .normal)
            self.questionLabel.text = "Game over!"
            SoundManager.shared.playSound(sound: .wrongAnswer)
            self.returnButton.isHidden = true
            [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].forEach {
                $0.isUserInteractionEnabled = false
            }
            self.timerView.pause()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.openEndGame()
            }
            [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton].first {
                $0.title(for: .normal) == correctAnswer
            }?.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
        }
    }
    
    func pressedSecondaryButton(_ sender: UIButton) {
        sender.isEnabled = false
        sender.alpha = 0.5
    }
    
    @objc func close() {
        let mainVC = StartScreenVC()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
    func openEndGame() {
        let level = currentQuestionIndex! + 1
        let score: Int

        if level >= 10 {
            score = 25000
        } else if level >= 5 {
            score = 5000
        } else {
            score = 0
        }

        let viewModel = EndScreenViewModel(score: score, level: level)
        let endVC = EndScreenVC(viewModel: viewModel)
        
        endVC.modalPresentationStyle = .fullScreen

        present(endVC, animated: true)
    }

    
    @objc func openResult() {
        SoundManager.shared.pauseSound()
        let resultVC = ResultViewController()
        resultVC.selectedLevel = currentQuestionIndex
        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true)
    }
    
    @objc func fiftyHint() {
        pressedSecondaryButton(fiftyButton)

        guard let question = questions?[currentQuestionIndex!] else { return }

        let correct = question.correctAnswer
        let allAnswers = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        
        let incorrectButtons = allAnswers.filter { $0.title(for: .normal) != correct }.shuffled()
        incorrectButtons.prefix(2).forEach {
            $0.isEnabled = false
            $0.alpha = 0.5
        }
    }

    
    @objc func callHint() {
        pressedSecondaryButton(callButton)

        guard let question = questions?[currentQuestionIndex!] else { return }

        let correctAnswer = question.correctAnswer
        let allAnswers = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]

        let correctButton = allAnswers.first { $0.title(for: .normal) == correctAnswer }

        let suggestedAnswer: UIButton
        if Bool.random(probability: 0.7), let correct = correctButton {
            suggestedAnswer = correct
        } else {
            let wrongButtons = allAnswers.filter { $0.title(for: .normal) != correctAnswer }
            suggestedAnswer = wrongButtons.randomElement()!
        }

        let alert = UIAlertController(title: "Call to friend", message: "Friend thing this is correnct answer: \"\(suggestedAnswer.title(for: .normal)!)\"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
    
    @objc func audienceHint() {
        pressedSecondaryButton(audienceButton)

        guard let question = questions?[currentQuestionIndex!] else { return }

        let correctAnswer = question.correctAnswer
        let allAnswers = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]

        var votes = [UIButton: Int]()
        var totalVotes = 100
        let correctVotes = Bool.random(probability: 0.7) ? Int.random(in: 45...70) : Int.random(in: 10...30)
        totalVotes -= correctVotes

        if let correctButton = allAnswers.first(where: { $0.title(for: .normal) == correctAnswer }) {
            votes[correctButton] = correctVotes
        }
        let otherButtons = allAnswers.filter { $0.title(for: .normal) != correctAnswer }.shuffled()
        for (index, button) in otherButtons.enumerated() {
            if index == otherButtons.count - 1 {
                votes[button] = totalVotes
            } else {
                let v = Int.random(in: 0...(totalVotes / 2))
                votes[button] = v
                totalVotes -= v
            }
        }
        let message = votes.map {
            "\($0.key.title(for: .normal)!): \($0.value)%"
        }.joined(separator: "\n")

        let alert = UIAlertController(title: "Vote of people", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}
