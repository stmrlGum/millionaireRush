//
//  timer.swift
//  millionaireRush
//
//  Created by Григорий Душин on 22.07.2025.
//

import UIKit

final class StopwatchView: UIView {

    // MARK: - UI

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 22.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stopwatch")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "30"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Properties

    private var timer: Timer?
    private var remainingSeconds = 30
    var onFinish: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func start() {
        reset()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    func pause() {
        timer?.invalidate()
    }

    func resume() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    func reset() {
        timer?.invalidate()
        remainingSeconds = 30
        updateAppearance()
        updateLabel()
    }

    // MARK: - Timer Logic

    @objc private func updateTimer() {
        remainingSeconds -= 1
        updateLabel()
        updateAppearance()

        if remainingSeconds <= 0 {
            timer?.invalidate()
            onFinish?()
        }
    }

    private func updateLabel() {
        timeLabel.text = String(format: "%02d", remainingSeconds)
    }

    private func updateAppearance() {
        
        switch remainingSeconds {
        case 0...5:
            containerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            timeLabel.textColor = .red
            iconView.tintColor = .red
        case 6...15:
            containerView.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
            timeLabel.textColor = .orange
            iconView.tintColor = .orange
        default:
            containerView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            timeLabel.textColor = .white
            iconView.tintColor = .white
        }
    }

    // MARK: - Layout

    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(timeLabel)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 88),
            containerView.heightAnchor.constraint(equalToConstant: 45),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),

            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),

            timeLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            timeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}


// HOW TO USE

// ДОБАВЛЕНИЕ НА ЭКРАН

//private let stopwatch = StopwatchView()
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = UIColor.systemBlue
//
//    view.addSubview(stopwatch)
//    stopwatch.translatesAutoresizingMaskIntoConstraints = false
//
//    NSLayoutConstraint.activate([
//        stopwatch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        stopwatch.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    ])

// ДЕЙСТВИЕ ПРИ ЗАВЕРШЕНИИ ОТСЧЕТА

//    stopwatch.onFinish = {  [weak self] in
//        let alert = UIAlertController(title: "Время вышло", message: "Секундомер завершён", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        self?.present(alert, animated: true)
//    }
//

// ПАУЗА (ПРИ ПОДСКАЗКАХ?)

// stopwatch.pause()

//ЗАПУСК

//    stopwatch.start()
//}
//}

///
