//
//  QuizStorage.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import Foundation
import RealmSwift

extension Quiz: Entity {
    private var storableQuiz: QuizStorage {
        let realm = QuizStorage()
        realm.uuid = uuid
        realm.idx = idx
        realm.levelIdx = levelIdx
        realm.completeTime = completeTime
        
        realm.block1Max = block1.max
        realm.block1Num = block1.num
        realm.block2Max = block2.max
        realm.block2Num = block2.num
        realm.answerMax = answer.max
        realm.answerNum = answer.num
        return realm
    }
    
    func toStorable() -> QuizStorage {
        return storableQuiz
    }
}

class QuizStorage: Object, Storable {
    @Persisted(primaryKey: true) var uuid: String = ""
    @Persisted var idx: Int
    @Persisted var levelIdx: Int
    @Persisted var completeTime: Int = 0
    
    @Persisted var block1Max: Int
    @Persisted var block1Num: Int
    @Persisted var block2Max: Int
    @Persisted var block2Num: Int
    @Persisted var answerMax: Int
    @Persisted var answerNum: Int
    
    var model: Quiz {
        get {
            return Quiz(idx: idx, levelIdx: levelIdx, isSolved: false, completeTime: completeTime, block1: Block(max: block1Max, num: block1Num), block2: Block(max: block2Max, num: block2Num), answer: Block(max: answerMax, num: answerNum))
        }
    }
}
