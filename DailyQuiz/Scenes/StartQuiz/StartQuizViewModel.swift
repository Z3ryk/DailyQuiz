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

    private let httpClient: HTTPClient
    private let router: AppRouter

    @Published var state: StartQuizView.State = .initial

    // MARK: - Lifecycle

    init(httpClient: HTTPClient, router: AppRouter) {
        self.httpClient = httpClient
        self.router = router
    }

    // MARK: - Internal

    func loadQuizInfo() {
        Task { [weak self] in
            guard let self else { return }

            state = .loading

            do {
                let quizInfo: QuizInfo = try await httpClient.get(from: Constants.quizURL)

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
    
    func navigateToHistory() {
        router.navigateToHistory()
    }
}

private extension StartQuizViewModel {
    enum Constants {
        static let quizURL: String = "https://opentdb.com/api.php?amount=5&category=23&difficulty=easy&type=multiple"
    }
}
