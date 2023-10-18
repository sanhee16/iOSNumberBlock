//
//  LevelRepository.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation

class LevelRepository: AnyRepository<Level> {
    func getLevelFromIdx(_ idx: Int) -> Level? {
        return self.getAll(where: NSPredicate(format: "idx == %d", idx)).first
    }
}
