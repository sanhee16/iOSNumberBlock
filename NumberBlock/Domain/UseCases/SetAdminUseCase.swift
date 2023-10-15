//
//  SetAdminUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/15.
//

import Foundation

protocol SetAdminUseCase {
    func execute(_ onComplete: @escaping () -> ())
}

final class DefaultSetAdminUseCase: SetAdminUseCase {
    private let unitRepository: UnitRepository
    private let levelRepository: LevelRepository
    private let quizRepository: QuizRepository

    init(
        unitRepository: UnitRepository,
        levelRepository: LevelRepository,
        quizRepository: QuizRepository
    ) {
        self.unitRepository = unitRepository
        self.levelRepository = levelRepository
        self.quizRepository = quizRepository
    }

    func execute(_ onComplete: @escaping () -> ()) {
        let unitList = unitRepository.getAll()
        let levelList = levelRepository.getAll()
        let quizList = quizRepository.getAll()
        for item in unitList {
            var updatedItem = item
            updatedItem.openTime = Int(Date().timeIntervalSince1970)
            try? unitRepository.update(item: updatedItem)
        }
        for item in levelList {
            var updatedItem = item
            updatedItem.openTime = Int(Date().timeIntervalSince1970)
            try? levelRepository.update(item: updatedItem)
        }
        for item in quizList {
            var updatedItem = item
            try? quizRepository.update(item: updatedItem)
        }
        onComplete()
    }
}
