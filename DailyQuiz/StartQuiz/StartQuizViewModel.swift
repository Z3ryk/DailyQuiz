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
        Task { [weak self] in
            guard let self else { return }

            state = .loading

            do {
                let quizInfo = try await networkService.loadQuizInfo()

                guard quizInfo.responseCode == 0 else {
                    state = .error
                    return
                }

                router.navigateToQuiz(with: quizInfo)
                state = .initial
            } catch {
                state = .error
            }
        }
    }
}
