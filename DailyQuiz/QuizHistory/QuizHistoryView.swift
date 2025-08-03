//
//  QuizHistoryView.swift
//  DailyQuiz
//
//  Created by Z3ryk on 03.08.2025.
//

import SwiftUI

struct QuizHistoryView: View {
    // MARK: - Properties

    @ObservedObject
    private var viewModel: QuizHistoryViewModel

    // MARK: - Views

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.historyItems.isEmpty {
                VStack {
                    emptyStateView

                    Spacer()

                    footerView
                }
                .padding(.top, 40)
                .padding(.horizontal, 16)
                .padding(.bottom, 76)
            } else {
                historyListView
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purpleMain)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: viewModel.popToRoot,
                    label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                    }
                )
                .frame(width: 24, height: 24, alignment: .center)
            }

            ToolbarItem(placement: .principal) {
                Text(String(localized: "history"))
                    .font(.system(size: 32, weight: .black))
                    .foregroundStyle(.white)
            }
        }
        .overlay {
            if viewModel.showingDeleteConfirmationAlert {
                AlertView(
                    title: String(localized: "quiz_deleted"),
                    subtitle: String(localized: "try_again"),
                    buttonTitle: String(localized: "ok"),
                    action: viewModel.dismissDeleteConfirmationAlert
                )
            }
        }
    }

    // MARK: - Empty State View

    private var emptyStateView: some View {
        VStack(spacing: 40) {
            Text(String(localized: "no_quiz"))
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)

            Button(action: viewModel.popToRoot) {
                Text(String(localized: "start_quiz"))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.purpleMain)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 8)
        }
        .padding(32)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 46))
    }

    // MARK: - History List View

    private var historyListView: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.historyItems) { item in
                    HistoryItemView(
                        title: item.title,
                        score: item.score,
                        date: viewModel.formattedDate(for: item),
                        time: viewModel.formattedTime(for: item)
                    )
                    .contextMenu(
                        menuItems: {
                            Button(role: .destructive) {
                                viewModel.deleteItem(item)
                            } label: {
                                Label(String(localized: "delete"), systemImage: "trash")
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 26)
        }
        .padding(.top, 40)
    }

    // MARK: - Footer View

    private var footerView: some View {
        Image(.logo)
            .resizable()
            .frame(width: 180, height: 40)
    }

    // MARK: - Lifecycle

    init(viewModel: QuizHistoryViewModel) {
        self.viewModel = viewModel
    }
}

#Preview("Empty state") {
    QuizHistoryView(viewModel: QuizHistoryViewModel(router: AppRouter()))
}

