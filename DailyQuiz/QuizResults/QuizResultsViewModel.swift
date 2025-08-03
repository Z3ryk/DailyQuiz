//
//  QuizResultsViewModel.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

final class QuizResultsViewModel: ObservableObject {
    // MARK: - State
    
    struct State {
        var score: Int
        var totalQuestions: Int
    }
    
    @Published var state: State
    
    // MARK: - Properties
    
    private var router: AppRouter
    
    // MARK: - Computed Properties
    
    var scoreText: String {
        "\(state.score) из \(state.totalQuestions)"
    }
    
    var resultTitle: String {
        switch state.score {
        case 5: "Идеально!"
        case 4: "Почти идеально!"
        case 3: "Хороший результат!"
        case 2: "Есть над чем поработать!"
        case 1: "Сложный вопрос?"
        default: "Бывает и так!"
        }
    }
    
    var resultDescription: String {
        switch state.score {
        case 5: "\(scoreText)" + String(localized: "results_description_five")
        case 4: "\(scoreText)" + String(localized: "results_description_four")
        case 3: "\(scoreText)" + String(localized: "results_description_three")
        case 2: "\(scoreText)" + String(localized: "results_description_two")
        case 1: "\(scoreText)" + String(localized: "results_description_one")
        default: "\(scoreText)" + String(localized: "results_description_zero")
        }
    }
    
    // MARK: - Lifecycle

    init(score: Int, totalQuestions: Int, router: AppRouter) {
        self.state = State(
            score: score,
            totalQuestions: totalQuestions
        )
        self.router = router
    }
    
    // MARK: - Navigation

    func startOver() {
        router.path.removeAll()
    }
}
