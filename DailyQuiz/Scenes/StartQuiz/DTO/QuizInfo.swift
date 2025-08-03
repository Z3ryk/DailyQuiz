//
//  QuizInfo.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import Foundation

struct QuizInfo: Decodable, Hashable {
    let responseCode: Int
    let results: [Result]

    struct Result: Decodable, Hashable {
        let type: String
        let difficulty: String
        let category: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
    }

    static let mock: Self = QuizInfo(
        responseCode: 0,
        results: [
            QuizInfo.Result(
                type: "multiple",
                difficulty: "easy",
                category: "General Knowledge",
                question: "What is the capital of France?",
                correctAnswer: "Paris",
                incorrectAnswers: ["London", "Berlin", "Madrid"]
            )
        ]
    )
}
