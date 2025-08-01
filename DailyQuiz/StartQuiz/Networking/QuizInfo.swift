//
//  QuizInfo.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import Foundation

struct QuizInfo: Decodable {
    let responseCode: Int
    let results: [Result]

    struct Result: Decodable {
        let type: String
        let difficulty: String
        let category: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
    }
}
