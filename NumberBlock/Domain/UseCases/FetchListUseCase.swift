//
//  FetchListUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import Foundation

protocol FetchListUseCase {
    associatedtype ListType
    func execute(idx: Int) -> [ListType]
}

extension FetchListUseCase {
    func execute(idx: Int = -1) -> [ListType] {
        return execute(idx: idx)
    }
}

final class FetchUnitListUseCase: FetchListUseCase {
    typealias ListType = Unit
    
    private let unitRepository: UnitRepository

    init(
        unitRepository: UnitRepository
    ) {
        self.unitRepository = unitRepository
    }

    func execute() -> [ListType] {
        self.unitRepository.getAll()
    }
}

final class FetchLevelListUseCase: FetchListUseCase {
    typealias ListType = Level
    private let levelRepository: LevelRepository

    init(
        levelRepository: LevelRepository
    ) {
        self.levelRepository = levelRepository
    }

    func execute(idx: Int) -> [ListType] {
        self.levelRepository.getAll(where: NSPredicate(format: "unitIdx == %d", idx))
    }
}


final class FetchQuizListUseCase: FetchListUseCase {
    typealias ListType = Quiz
    private let quizRepository: QuizRepository

    init(
        quizRepository: QuizRepository
    ) {
        self.quizRepository = quizRepository
    }

    func execute(idx: Int) -> [ListType] {
        self.quizRepository.getAll(where: NSPredicate(format: "levelIdx == %d", idx))
    }
}
