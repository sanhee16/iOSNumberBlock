//
//  UnitRepository.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation

class UnitRepository: AnyRepository<Unit> {
    func getUnitFromIdx(_ idx: Int) -> Unit? {
        return self.getAll(where: NSPredicate(format: "idx == %d", idx)).first
    }
}
