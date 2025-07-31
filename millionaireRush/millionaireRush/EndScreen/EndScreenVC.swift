//
//  EndScreenVC.swift
//  millionaireRush
//
//  Created by Григорий Душин on 26.07.2025.
//

import UIKit

final class EndScreenVC: UIViewController {

    // MARK: - Dependencies
    private let viewModel: EndScreenViewModel

    // MARK: - Init
    init(viewModel: EndScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Элементы

    private lazy var backgroundImageView = createBackgroundImageView()
    private lazy var scoreLabelStack = createScoreLabelStack()
    private lazy var mainScreenButton = createMainScreenButton()
    private lazy var newGameButton = createNewGameButton()
    private lazy var textLabel = createTextLabel()
    private lazy var logoMillionaire = createLogoImageView()
    private lazy var allTimeScoreTextLabel = createAllTimeScoreTextLabel()
    private lazy var allTimeScoreLabel = createAllTimeScoreLabel()
    private lazy var coinImage = createCoinImageView()

    // MARK: - Life cycle

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

    // MARK: - UI Configuration

    private func configureUI() {
        allTimeScoreTextLabel.text = viewModel.levelText
        allTimeScoreLabel.text = viewModel.scoreText
    }


    // MARK: - UI Factory

    private func createBackgroundImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func createScoreLabelStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func createMainScreenButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Main screen", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(pressedMainScreenButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func createNewGameButton() -> UIButton {
        let button = UIButton()
        button.setTitle("New game", for: .normal)
        button.setBackgroundImage(UIImage(named: "blueButton"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(pressedNewGameButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func createTextLabel() -> UILabel {
        let label = UILabel()
        label.text = "Game over!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createLogoImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func createAllTimeScoreTextLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createAllTimeScoreLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createCoinImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "coin"))
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    @objc private func pressedMainScreenButton(_ sender: UIButton) {
        sender.changeState()
        let mainVC = StartScreenVC()
        
        setRootViewController(mainVC)
    }

    @objc private func pressedNewGameButton(_ sender: UIButton) {
        sender.changeState()
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
                debugPrint("Error: \(error)")
                DispatchQueue.main.async {
                    sender.isUserInteractionEnabled = true
                    let alert = UIAlertController(title: "Bad request", message: "Bad internet connection, check connection and turn off VPN", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

    func openGame(isContinue: Bool) {
        let gameVC = GameViewController()
        gameVC.isContunueGame = isContinue
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true)
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
                          animations: nil)
    }
}
