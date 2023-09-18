//
//  QuizData.swift
//  NumberBlock
//
//  Created by sandy on 2023/09/18.
//

import Foundation


struct QuizData {
    var max: Int
    var block1: Int
    var block2: Int
    var isSolved: Bool
    var answerBlock: [Bool] = []
    
    init(max: Int, block1: Int, block2: Int, isSolved: Bool, answerBlock: [Bool] = []) {
        self.max = max
        self.block1 = block1
        self.block2 = block2
        self.isSolved = isSolved
        self.answerBlock = Array(repeating: false, count: max)
    }
}
