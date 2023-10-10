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

    init(
        unitRepository: UnitRepository,
        levelRepository: LevelRepository
    ) {
        self.unitRepository = unitRepository
        self.levelRepository = levelRepository
    }

    func execute(
//        requestValue: InitalizeDBUseCaseRequestValue,
        completion: @escaping () -> ()
    ) {
        
        for i in 0..<5 {
            try? self.unitRepository.insert(item: Unit(idx: i, openTime: i == 0 ? Int(Date().timeIntervalSince1970) : 0))
        }
        
        for i in 0..<5 {
            for j in 0..<100 {
                try? self.levelRepository.insert(item: Level(idx: j, unitIdx: i))
            }
        }
        
        completion()
    }
}

struct InitalizeDBUseCaseRequestValue {
    
}
