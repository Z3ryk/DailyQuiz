//
//  StartQuizViewModel.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import Foundation

@MainActor
final class StartQuizViewModel: ObservableObject {
    // MARK: - Properties

    private let networkService: QuizInfoNetworkService
    private let router: AppRouter

    @Published var state: StartQuizView.State = .initial

    // MARK: - Lifecycle

    init(router: AppRouter) {
        self.networkService = QuizInfoNetworkService()
        self.router = router
    }

    // MARK: - Internal

    func loadQuizInfo() {
        Task {
            self.state = .loading

            do {
                let _ = try await networkService.loadQuizInfo()
                self.state = .initial
            } catch {
                self.state = .error
            }
        }
    }
}
