//
//  UnitRepository.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//
import Foundation

class UnitRepository: AnyRepository<Unit> {
    func initRepository() {
        for i in 0..<2 {
            try? self.insert(item: Unit(idx: i))
        }
    }
}
