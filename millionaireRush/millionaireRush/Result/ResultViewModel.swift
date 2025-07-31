//
//  ResultViewModel.swift
//  millionaireRush
//
//  Created by Danil on 01.08.2025.
//

import Foundation

class ResultViewModel {
    
    let levels: [Level] = [
        Level(number: 15, prize: "$1,000,000"),
        Level(number: 14, prize: "$500,000"),
        Level(number: 13, prize: "$250,000"),
        Level(number: 12, prize: "$100,000"),
        Level(number: 11, prize: "$50,000"),
        Level(number: 10, prize: "$25,000"),
        Level(number: 9, prize: "$15,000"),
        Level(number: 8, prize: "$12,500"),
        Level(number: 7, prize: "$10,000"),
        Level(number: 6, prize: "$7,500"),
        Level(number: 5, prize: "$5,000"),
        Level(number: 4, prize: "$3,000"),
        Level(number: 3, prize: "$2,000"),
        Level(number: 2, prize: "$1,000"),
        Level(number: 1, prize: "$500")
    ]
    
    let guaranteedLevels = [15]
    var currentLevels = [10, 5]
    var selectedLevel: Int?
    
    func level(at index: Int) -> Level {
        return levels[index]
    }
    
    func isCurrent(level: Int) -> Bool {
        return currentLevels.contains(level)
    }
    
    func isGuaranteed(level: Int) -> Bool {
        return guaranteedLevels.contains(level)
    }
    
    func numberOfLevels() -> Int {
        return levels.count
    }

    func prizeForSelectedLevel() -> String? {
        guard let selected = selectedLevel else { return nil }
        return levels.first { $0.number == selected }?.prize
    }
}
