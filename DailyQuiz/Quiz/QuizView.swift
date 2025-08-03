//
//  QuizView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 02.08.2025.
//

import SwiftUI

struct QuizView: View {
    // MARK: - Properties

    @ObservedObject
    private var viewModel: QuizViewModel

    // MARK: - Views

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: viewModel.navigateToStart) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24, alignment: .center)
                        .font(.system(size: 20, weight: .semibold))
                }

                Spacer()

                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)

                Spacer()
            }
            .padding(.top, 36)
            .padding(.horizontal, 26)

            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    HStack {
                        Text(viewModel.elapsedTimeText)
                            .foregroundStyle(.purpleDark)
                            .font(.system(size: 10, weight: .regular))

                        Spacer()

                        Text(viewModel.totalTimeInMinutes)
                            .foregroundStyle(.purpleDark)
                            .font(.system(size: 10, weight: .regular))
                    }

                    ProgressView(value: viewModel.progressValue)
                        .progressViewStyle(LinearProgressViewStyle(tint: .purpleDark))
                        .scaleEffect(y: 1)
                }
                .padding(.horizontal, 16)

                Text(viewModel.questionNumberText)
                    .foregroundStyle(.purpleLight)
                    .font(.system(size: 16, weight: .semibold))

                Text(viewModel.currentQuestion.question)
                    .foregroundStyle(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 12) {
                    ForEach(viewModel.state.shuffledAnswers, id: \.self) { answer in
                        Button(action: {
                            viewModel.setSelectedAnswer(to: answer)
                        }) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(viewModel.state.selectedAnswer == answer ? Color.purpleDark : Color.white)
                                        .frame(width: 24, height: 24)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.black, lineWidth: 1)
                                        )

                                    if viewModel.state.selectedAnswer == answer {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                }

                                Text(answer)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16, weight: .regular))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(viewModel.state.selectedAnswer == answer ? Color.white : Color.gray.opacity(0.3))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(viewModel.state.selectedAnswer == answer ? Color.purpleDark : Color.clear, lineWidth: 1)
                                    )
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)

                Button(
                    action: {
                        withAnimation(.easeInOut) {
                            viewModel.checkAnswer()
                            viewModel.nextQuestion()
                        }
                    },
                    label: {
                        Text(String(localized: "next"))
                            .foregroundStyle(viewModel.state.selectedAnswer != nil ? .white : .gray)
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(viewModel.state.selectedAnswer != nil ? Color.purpleMain : Color.gray.opacity(0.3))
                            .cornerRadius(12)
                    }
                )
                .disabled(viewModel.state.selectedAnswer == nil)
                .padding(.horizontal, 16)
                .padding(.top, 43)
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 46))
            .padding(.horizontal, 26)
            .padding(.top, 40)

            Text(String(localized: "no_back"))
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(.white)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purpleMain)
        .navigationBarBackButtonHidden(true)
        .overlay {
            if viewModel.state.showTimerExpiredOverlay {
                AlertView(
                    title: String(localized: "time_expired"),
                    subtitle: String(localized: "time_expired_try_again"),
                    buttonTitle: String(localized: "start_over"),
                    action: viewModel.navigateToStart
                )
            }
        }
    }

    // MARK: - Lifecycle

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    NavigationStack {
        QuizView(
            viewModel: QuizViewModel(
                quizInfo: .mock,
                router: AppRouter()
            )
        )
    }
}
