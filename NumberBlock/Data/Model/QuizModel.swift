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
    var uuid: String
    var idx: Int // idx, 순서
    var levelIdx: Int // Level Idx
    var isSolved: Bool = false
    
    var block1: Int
    var block2: Int
    var answer: Int
}
