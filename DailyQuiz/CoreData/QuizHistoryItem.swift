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

    private let dateFormatter = DateFormatter()

    var starsCount: Int {
        let percentage = Double(score) / Double(totalQuestions)
        return Int(percentage * 5)
    }
    
    var formattedDate: String {
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: completedAt).lowercased()
    }
    
    var formattedTime: String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: completedAt)
    }
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
