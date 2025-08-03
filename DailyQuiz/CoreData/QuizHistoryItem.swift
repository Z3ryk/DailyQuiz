//
//  QuizHistoryItem.swift
//  DailyQuiz
//
//  Created by Z3ryk on 03.08.2025.
//

import Foundation

struct QuizHistoryItem: Identifiable {
    let id: UUID
    let title: String
    let score: Int
    let totalQuestions: Int
    let completedAt: Date
}

extension QuizHistoryItem {
    init(from entity: QuizHistoryEntity) {
        guard let id = entity.id, let title = entity.title else {
            fatalError("Сущность должна иметь ID и заголовок")
        }

        self.id = id
        self.title = title
        self.score = Int(entity.score)
        self.totalQuestions = Int(entity.totalQuestions)
        self.completedAt = entity.completedAt ?? Date()
    }
}
