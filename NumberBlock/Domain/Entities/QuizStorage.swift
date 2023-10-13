//
//  QuizStorage.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import Foundation
import RealmSwift

extension Quiz: Entity {
    var answer: Int {
        self.block1.num + self.block2.num
    }
    
    private var storableQuiz: QuizStorage {
        let realm = QuizStorage()
        realm.uuid = uuid
        realm.idx = idx
        realm.levelIdx = levelIdx
        realm.completeTime = completeTime
        
        realm.block1Num = block1.num
        realm.block2Num = block2.num
        return realm
    }
    
    func toStorable() -> QuizStorage {
        return storableQuiz
    }
    
    
}

class QuizStorage: Object, Storable {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var idx: Int
    @Persisted var levelIdx: Int
    @Persisted var completeTime: Int = 0
    
    @Persisted var block1Num: Int
    @Persisted var block2Num: Int
    
    var model: Quiz {
        get {
            return Quiz(uuid: uuid, idx: idx, levelIdx: levelIdx, isSolved: false, completeTime: completeTime, block1: Block(num: block1Num), block2: Block(num: block2Num))
        }
    }
}
