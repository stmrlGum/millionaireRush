//
//  EndScreenVC.swift
//  millionaireRush
//
//  Created by Григорий Душин on 26.07.2025.
//

import UIKit

final class EndScreenVC: UIViewController {

    // MARK: - Public Props (устанавливаются до появления экрана)
    var score: Int = 0       // передаётся из предыдущего экрана
    var level: Int = 0        // передаётся из предыдущего экрана

    // MARK: - UI Элементы

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

    private lazy var mainScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Main screen", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedMainScreenButton), for: .touchUpInside)
        return button
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Game over!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var logoMillionaire: UIImageView = {
        let logoImageView = UIImageView()
        let image = UIImage(named: "logo")
        logoImageView.image = image
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.clipsToBounds = true
        return logoImageView
    }()

    private lazy var allTimeScoreTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var allTimeScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("New game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedNewGameButton), for: .touchUpInside)
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

    // MARK: - Жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        [backgroundImageView, mainScreenButton, textLabel, logoMillionaire,
         newGameButton, allTimeScoreLabel, allTimeScoreTextLabel, scoreLabelStack]
            .forEach { view.addSubview($0) }

        scoreLabelStack.addArrangedSubview(allTimeScoreLabel)
        scoreLabelStack.addArrangedSubview(coinImage)
        

        setupConstraints()
        configureUI()
    }

    // MARK: - Настройка текста и данных

    private func configureUI() {
        allTimeScoreTextLabel.text = "Level \(level)"
        allTimeScoreLabel.text = "$\(score)"
    }

    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            mainScreenButton.heightAnchor.constraint(equalToConstant: 62),
            mainScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -109),
            mainScreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mainScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            newGameButton.heightAnchor.constraint(equalToConstant: 62),
            newGameButton.bottomAnchor.constraint(equalTo: mainScreenButton.topAnchor, constant: -16),
            newGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            newGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            textLabel.heightAnchor.constraint(equalToConstant: 76),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            textLabel.bottomAnchor.constraint(equalTo: allTimeScoreTextLabel.topAnchor, constant: -16),

            logoMillionaire.heightAnchor.constraint(equalToConstant: 250),
            logoMillionaire.widthAnchor.constraint(equalToConstant: 250),
            logoMillionaire.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoMillionaire.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -16),

            allTimeScoreTextLabel.heightAnchor.constraint(equalToConstant: 19),
            allTimeScoreTextLabel.bottomAnchor.constraint(equalTo: scoreLabelStack.topAnchor, constant: -8),
            allTimeScoreTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            allTimeScoreTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            scoreLabelStack.heightAnchor.constraint(equalToConstant: 32),
            scoreLabelStack.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -78),
            scoreLabelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            scoreLabelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),

            coinImage.heightAnchor.constraint(equalToConstant: 32),
            coinImage.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    // MARK: - Действия кнопок

    @objc func pressedMainScreenButton(_ sender: UIButton) {
        sender.animateTapHighlight()

        let mainVC = StartEndScreenVC()
        //navigationController?.pushViewController(mainVC, animated: true)
       
        setRootViewController(mainVC)
    }

    @objc func pressedNewGameButton(_ sender: UIButton) {
        sender.animateTapHighlight()

        let gameVC = GameViewController()
            //navigationController?.pushViewController(gameVC, animated: true)
        
            setRootViewController(gameVC)
        
    }

    
    func setRootViewController(_ vc: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()

        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


extension UIButton {
    func animateTapHighlight() {
        let originalImage = self.backgroundImage(for: .normal)
        self.setBackgroundImage(UIImage(named: "yellowButton"), for: .normal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.setBackgroundImage(originalImage, for: .normal)
        }
    }
}
