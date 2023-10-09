//
//  UnitRepository.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//
import Foundation

class UnitRepository: AnyRepository<Unit> {
    func initRepository() {
        for i in 0..<5 {
            try? self.insert(item: Unit(idx: i, openTime: i == 0 ? Int(Date().timeIntervalSince1970) : 0))
        }
    }
}
