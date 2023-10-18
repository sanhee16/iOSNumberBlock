//
//  SolveQuizUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/17.
//

import Foundation
import Combine


protocol SolveQuizUseCase {
    func execute(_ levelIdx: Int, score: Int)
}

final class DefaultSolveQuizUseCase: SolveQuizUseCase {
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
    
    func execute(_ levelIdx: Int, score: Int) {
        var updateLevel = self.levelRepository.getLevelFromIdx(levelIdx)
        updateLevel?.completeTime = Int(Date().timeIntervalSince1970)
        updateLevel?.score = score
        
        if let updateLevel = updateLevel {
            try? self.levelRepository.update(item: updateLevel)
            if let nextLevel = self.levelRepository.getLevelFromIdx(levelIdx + 1), nextLevel.unitIdx != updateLevel.unitIdx {
                var nextUpdateLevel = nextLevel
                nextUpdateLevel.openTime = Int(Date().timeIntervalSince1970)
                try? self.levelRepository.update(item: nextUpdateLevel)
            }
            
            if let currentUnit = self.unitRepository.getUnitFromIdx(updateLevel.unitIdx), let nextUnit = self.unitRepository.getUnitFromIdx(updateLevel.unitIdx + 1), currentUnit != nextUnit {
                var updateUnit = nextUnit
                updateUnit.completeTime = Int(Date().timeIntervalSince1970)
                var nextUpdateUnit = nextUnit
                nextUpdateUnit.openTime = Int(Date().timeIntervalSince1970)
                
                try? self.unitRepository.update(item: updateUnit)
                try? self.unitRepository.update(item: nextUpdateUnit)
            }
        }
    }
}

