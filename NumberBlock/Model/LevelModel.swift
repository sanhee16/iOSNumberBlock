//
//  LevelModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/04.
//

import Foundation

struct Level: Equatable, Hashable, Codable {
    static func == (lhs: Level, rhs: Level) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    var uuid: String = UUID().uuidString
    var idx: Int // idx, 순서
    var unitIdx: Int // Unit Idx
    var complete: Int? // epochTime
    var score: Int // Last Score
}