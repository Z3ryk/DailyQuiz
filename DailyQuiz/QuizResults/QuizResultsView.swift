//
//  QuizResultsView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

struct QuizResultsView: View {
    // MARK: - Properties
    
    @ObservedObject
    private var viewModel: QuizResultsViewModel
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Результаты")
                .foregroundStyle(.white)
                .font(.system(size: 32, weight: .black))
                .padding(.top, 32)
                .padding(.bottom, 40)

            VStack(spacing: 32) {
                HStack(spacing: 8) {
                    ForEach(0..<5, id: \.self) { index in
                        let isFilled = index < viewModel.state.score
                        let imageName = isFilled ? "custom_star_fill" : "custom_star"
                        
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 43, height: 43)
                    }
                }

                Text(viewModel.scoreText)
                    .foregroundStyle(.orange)
                    .font(.system(size: 18, weight: .semibold))

                Text(viewModel.resultTitle)
                    .foregroundStyle(.black)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)

                Text(viewModel.resultDescription)
                    .foregroundStyle(.black)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)

                Button(
                    action: { viewModel.startOver() },
                    label: {
                        Text("НАЧАТЬ ЗАНОВО")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(.purpleMain)
                            .cornerRadius(12)
                    }
                )
                .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 40)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 46))
            .padding(.horizontal, 26)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purpleMain)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Lifecycle

    init(viewModel: QuizResultsViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    NavigationStack {
        QuizResultsView(
            viewModel: QuizResultsViewModel(
                score: 4,
                totalQuestions: 5,
                router: AppRouter()
            )
        )
    }
}
