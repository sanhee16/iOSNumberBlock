//
//  SettingUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/15.
//

import Foundation

protocol SettingUseCase {
    func resetAll(_ onComplete: @escaping () -> ())
}

final class DefaultSettingUseCase: SettingUseCase {
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

    func resetAll(_ onComplete: @escaping () -> ()) {
        let unitList = unitRepository.getAll()
        let levelList = levelRepository.getAll()
        let quizList = quizRepository.getAll()
        for item in unitList {
            var updatedItem = Unit(uuid: item.uuid, idx: item.idx, title: item.title, subTitle: item.subTitle, openTime: 0, completeTime: 0)
            if item.idx == 0 {
                updatedItem.openTime = Int(Date().timeIntervalSince1970)
            }
            try? unitRepository.update(item: updatedItem)
        }
        for item in levelList {
            var updatedItem = Level(uuid: item.uuid, idx: item.idx, unitIdx: item.unitIdx, title: item.title, openTime: 0, completeTime: 0, score: 0)
            if item.idx == 0 {
                updatedItem.openTime = Int(Date().timeIntervalSince1970)
            }
            try? levelRepository.update(item: updatedItem)
        }
        for item in quizList {
            var updatedItem = Quiz(uuid: item.uuid, idx: item.idx, levelIdx: item.levelIdx, isSolved: false, completeTime: 0, score: 0, block1: item.block1, block2: item.block1, answer: item.answer)
            try? quizRepository.update(item: updatedItem)
        }
        onComplete()
    }
}
