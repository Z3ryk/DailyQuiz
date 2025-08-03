//
//  QuizHistoryManager.swift
//  DailyQuiz
//
//  Created by Z3ryk on 03.08.2025.
//

import Foundation
import CoreData

final class QuizHistoryManager: ObservableObject {
    // MARK: - Properties

    private(set) var entities: [QuizHistoryEntity] = []

    private let context: NSManagedObjectContext

    static let shared: QuizHistoryManager = .init()

    // MARK: - Lifecycle

    private init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context

        fetchAll()
    }

    // MARK: - Internal

    func fetchAll() {
        let request: NSFetchRequest<QuizHistoryEntity> = QuizHistoryEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \QuizHistoryEntity.completedAt, ascending: false)]

        do {
            entities = try context.fetch(request)
        } catch {
            entities = []
        }
    }

    func saveQuizHistoryItem(_ quizHistoryItem: QuizHistoryItem) {
        let _ = QuizHistoryEntity(from: quizHistoryItem, context: context)
        saveContext()
        fetchAll()
    }

    func deleteQuizHistoryItem(_ quizHistoryItem: QuizHistoryItem) {
        let request: NSFetchRequest<QuizHistoryEntity> = QuizHistoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", quizHistoryItem.id as CVarArg)
        request.fetchLimit = 1

        do {
            if let entityToDelete = try context.fetch(request).first {
                context.delete(entityToDelete)
                saveContext()
                fetchAll()
            } else {
                print("Не удалось найти объект с ID: \(quizHistoryItem.id)")
            }
        } catch {
            print("Не удалось получить данные:", error)
        }
    }

    // MARK: - Private

    private func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Не удалось сохранить контекст: ", error)
        }
    }
}

private extension QuizHistoryEntity {
    convenience init(from quizHistoryItem: QuizHistoryItem, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = quizHistoryItem.id
        self.title = quizHistoryItem.title
        self.totalQuestions = Int32(quizHistoryItem.totalQuestions)
        self.score = Int32(quizHistoryItem.score)
        self.completedAt = quizHistoryItem.completedAt
    }
}
