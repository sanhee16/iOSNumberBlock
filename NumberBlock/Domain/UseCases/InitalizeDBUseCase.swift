//
//  InitalizeDBUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import Foundation

protocol InitalizeDBUseCase {
    func execute(
        //        requestValue: InitalizeDBUseCaseRequestValue,
        completion: @escaping () -> ()
    )
}

final class DefaultInitalizeDBUseCase: InitalizeDBUseCase {
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
    
    func execute(
        //        requestValue: InitalizeDBUseCaseRequestValue,
        completion: @escaping () -> ()
    ) {
        initUnit()
        initLevel()
        initQuiz()
        
        completion()
    }
    
    private func initUnit() {
        for i in 0..<5 {
            try? self.unitRepository.insert(item: Unit(idx: i, openTime: i == 0 ? Int(Date().timeIntervalSince1970) : 0))
        }
    }
    private func initLevel() {
        for i in 0..<5 {
            for j in 0..<100 {
                try? self.levelRepository.insert(item: Level(idx: j, unitIdx: i, openTime: j == 0 ? Int(Date().timeIntervalSince1970) : 0))
            }
        }
        
    }
    private func initQuiz() {
        for i in 0..<20 { // level
            for j in 0..<10 { // quiz
                let block1Num: Int = Int.random(in: 0..<6)
                let block2Num: Int = Int.random(in: 0..<6)
                try? self.quizRepository.insert(item: Quiz (
                    idx: j, levelIdx: i, openTime: j == 0 ? Int(Date().timeIntervalSince1970) : 0,
                    block1: Block(max: 10, num: block1Num), block2: Block(max: 10, num: block2Num), answer: Block(max: 10, num: block1Num + block2Num))
                )
            }
        }
        
    }
}

struct InitalizeDBUseCaseRequestValue {
    
}
