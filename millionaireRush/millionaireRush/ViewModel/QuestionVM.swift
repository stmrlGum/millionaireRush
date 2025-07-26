//
//  QuestionVM.swift
//  millionaireRush
//
//  Created by Danil on 24.07.2025.
//

struct MillionareVM {
    let responseCode: Int
    let results: [QuestionVM]
    
    
    init(responseCode: Int,
         results: [QuestionVM]) {
        self.responseCode = responseCode
        self.results = results
    }
    
    init(json: [String: Any]) {
        let responseCode = json["response_code"] as? Int ?? 0
        let quest = json["results"] as? [[String: Any]]
        let results = quest?.compactMap({ item in
            return QuestionVM(json: item)
        }) ?? []
        
        self.responseCode = responseCode
        self.results = results
    }
}

struct QuestionVM {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    init(question: String,
         correctAnswer: String,
         incorrectAnswers: [String]) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
    
    init(json: [String: Any]) {
        let question = json["question"] as? String ?? ""
        let correctAnswer = json["correct_answer"] as? String ?? ""
        let incorrectAnswers = json["incorrect_answers"] as? [String] ?? []
        
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
    
}
