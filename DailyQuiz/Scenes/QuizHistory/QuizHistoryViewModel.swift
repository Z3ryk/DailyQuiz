//
//  QuizHistoryViewModel.swift
//  DailyQuiz
//
//  Created by Z3ryk on 03.08.2025.
//

import Foundation
import CoreData

@MainActor
final class QuizHistoryViewModel: ObservableObject {
    // MARK: - Properties
    
    private let router: AppRouter
    private let historyManager: QuizHistoryManager
    private let dateFormatter: DateFormatter = .init()

    @Published private(set) var historyItems: [QuizHistoryItem] = []
    @Published private(set) var showingDeleteConfirmationAlert = false

    // MARK: - Lifecycle
    
    init(router: AppRouter, historyManager: QuizHistoryManager = .shared) {
        self.router = router
        self.historyManager = historyManager

        getItemsFromStorage()
    }
    
    // MARK: - Internal
    
    func deleteItem(_ item: QuizHistoryItem) {
        historyManager.deleteQuizHistoryItem(item)
        showingDeleteConfirmationAlert = true
    }
    
    func popToRoot() {
        router.popToRoot()
    }

    func dismissDeleteConfirmationAlert() {
        showingDeleteConfirmationAlert = false
        getItemsFromStorage()
    }

    // MARK: - Private

    private func getItemsFromStorage() {
        self.historyItems = historyManager.entities.map { QuizHistoryItem(from: $0) }
    }
}

extension QuizHistoryViewModel {
    func formattedDate(for item: QuizHistoryItem) -> String {
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: item.completedAt).lowercased()
    }

    func formattedTime(for item: QuizHistoryItem) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: item.completedAt)
    }
}
