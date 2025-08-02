//
//  Screen.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

enum Screen: Hashable {
    case quiz(quizInfo: QuizInfo)
    case results(score: Int, totalQuestions: Int)

    @ViewBuilder
    @MainActor
    func destinationView(router: AppRouter) -> some View {
        switch self {
        case .quiz(let quizInfo):
            QuizView(viewModel: QuizViewModel(quizInfo: quizInfo, router: router))
        case let .results(score, totalQuestions):
            QuizResultsView(
                viewModel: QuizResultsViewModel(
                    score: score,
                    totalQuestions: totalQuestions,
                    router: router
                )
            )
        }
    }
}
