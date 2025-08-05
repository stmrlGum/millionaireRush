//
//  GameViewModel.swift
//  millionaireRush
//
//  Created by Danil on 02.08.2025.
//

import Foundation

class GameViewModel {
    
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

    var questionText: String {
        guard let question = questions?[currentQuestionIndex!] else { return "" }
        return question.question.removingHTMLEntities()
    }
    
    var answers: [String] {
        guard let question = questions?[currentQuestionIndex!] else { return [] }
        return ([question.correctAnswer] + question.incorrectAnswers).shuffled().map { $0.removingHTMLEntities() }
    }

    var questionNumberText: String {
        if let level = levels.first(where: { $0.number == currentQuestionIndex! + 1 }) {
            return "QUESTION #\(level.number)"
        }
        return ""
    }
    
    var costText: String {
        if let level = levels.first(where: { $0.number == currentQuestionIndex! + 1 }) {
            return level.prize
        }
        return ""
    }

    func isCorrectAnswer(_ answer: String) -> Bool {
        return answer == questions![currentQuestionIndex!].correctAnswer
    }

    func getCorrectAnswer() -> String {
        return questions![currentQuestionIndex!].correctAnswer
    }

    func getNextQuestionExists() -> Bool {
        return currentQuestionIndex! < questions!.count
    }

    func getPrizeLevel() -> Int {
        let level = currentQuestionIndex! + 1
        if level >= 10 {
            return 25000
        } else if level >= 5 {
            return 5000
        } else {
            return 0
        }
    }
}

