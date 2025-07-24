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


/*
 struct TrendsVM {
     let id: Int
     let title: String
     let subtitle: String
     let imageUrl: String
     let description: String
     let date: Date
     let inSlider: Bool
     let cards: [TrendsFittingVM]

     init(id: Int,
          title: String,
          subtitle: String,
          imageUrl: String,
          description: String,
          date: Date,
          inSlider: Bool,
          cards: [TrendsFittingVM]) {
         self.id = id
         self.title = title
         self.subtitle = subtitle
         self.imageUrl = imageUrl
         self.description = description
         self.date = date
         self.inSlider = inSlider
         self.cards = cards
     }

     init(json: JSONDictionary) {
         let id = json["id"] as? Int ?? 0
         let title = json["title"] as? String ?? ""
         let subtitle = json["subtitle"] as? String ?? ""
         let imageUrl = json["image_url"] as? String ?? ""
         let description = json["description"] as? String ?? ""
         let date = json["publication_date"] as? Date ?? Date()
         let inSlider = json["in_slider"] as? Bool ?? false
         let array = json["cards"] as? [JSONDictionary]
         let cards = array?.compactMap({ item in
             return TrendsFittingVM(json: item)
         }) ?? []

         self.id = id
         self.title = title
         self.subtitle = subtitle
         self.imageUrl = imageUrl
         self.description = description
         self.date = date
         self.inSlider = inSlider
         self.cards = cards
     }
 }
 */
