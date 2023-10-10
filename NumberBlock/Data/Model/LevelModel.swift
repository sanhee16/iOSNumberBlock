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
    var openTime: Int = 0  // epochTime
    var completeTime: Int = 0  // epochTime
    var score: Int = 0 // Last Score
}
