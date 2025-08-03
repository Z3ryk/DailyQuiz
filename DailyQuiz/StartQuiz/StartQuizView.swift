//
//  StartQuizView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import SwiftUI
import CoreData

struct StartQuizView: View {
    // MARK: - State

    enum State {
        case initial
        case loading
        case error
    }

    // MARK: - Properties

    @ObservedObject
    private var viewModel: StartQuizViewModel

    // MARK: - Views

    var body: some View {
        VStack {
            HistoryButtonView {
                viewModel.navigateToHistory()
            }
            .disabled(viewModel.state == .loading)
            .padding(.top, 46)

            Image(.logo)
                .padding(.top, 114)

            switch viewModel.state {
            case .initial, .error:
                QuizLaunchView {
                    viewModel.loadQuizInfo()
                }
                .padding(.top, 40)
                .padding(.horizontal, 16)

                if case .error = viewModel.state {
                    Text(String(localized: "download_error"))
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .black))
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
                }

            case .loading:
                ProgressView()
                    .controlSize(.large)
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.top, 120)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purpleMain)
    }

    // MARK: - Lifecycle

    init(viewModel: StartQuizViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    StartQuizView(viewModel: StartQuizViewModel(router: AppRouter()))
}
