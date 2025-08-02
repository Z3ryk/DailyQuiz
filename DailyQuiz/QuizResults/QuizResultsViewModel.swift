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
        case 5: "\(scoreText) — вы ответили на всё правильно.\nЭто блестящий результат!"
        case 4: "\(scoreText) — очень близко к совершенству.\nЕщё один шаг!"
        case 3: "\(scoreText) — вы на верном пути.\nПродолжайте тренироваться!"
        case 2: "\(scoreText) — не расстраивайтесь,\nпопробуйте ещё раз!"
        case 1: "\(scoreText) - иногда просто не ваш день.\nСледующая попытка будет лучше!"
        default: "\(scoreText) — не отчаивайтесь.\nНачните заново и удивите себя!"
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
