//
//  EndScreenViewModel.swift
//  millionaireRush
//
//  Created by Григорий Душин on 31.07.2025.
//

import Foundation

final class EndScreenViewModel {
    // Входные данные
    let score: Int
    let level: Int

    // Callback'и для действий
    var onNewGame: (() -> Void)?
    var onMainScreen: (() -> Void)?

    init(score: Int, level: Int) {
        self.score = score
        self.level = level
    }

    var levelText: String {
        "Level \(level)"
    }

    var scoreText: String {
        "$\(score)"
    }

    func newGameTapped() {
        onNewGame?()
    }

    func mainScreenTapped() {
        onMainScreen?()
    }
}
