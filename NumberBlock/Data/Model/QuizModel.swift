//
//  QuizModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/04.
//

import Foundation

struct Quiz: Equatable, Hashable {
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    var uuid: String = UUID().uuidString
    var idx: Int // idx, 순서
    var levelIdx: Int // Level Idx
    var isSolved: Bool = false
    var completeTime: Int = 0 // 문제 푼 날짜 epochTime
    var score: Int = 0
    
    var block1: Block
    var block2: Block
}
