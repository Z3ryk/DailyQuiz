//
//  QuizInfoNetworkService.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import Foundation

struct QuizInfoNetworkService {
    func loadQuizInfo() async throws -> QuizInfo {
        guard
            let url = URL(string: "https://opentdb.com/api.php?amount=5&category=23&difficulty=easy&type=multiple")
        else { throw URLError(.badURL) }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(QuizInfo.self, from: data)
    }
}
