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
        
        realm.block1 = block1
        realm.block2 = block2
        realm.answer = answer
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
    
    @Persisted var block1: Int
    @Persisted var block2: Int
    @Persisted var answer: Int
    
    var model: Quiz {
        get {
            return Quiz(uuid: uuid, idx: idx, levelIdx: levelIdx, isSolved: false, block1: block1, block2: block2, answer: answer)
        }
    }
}
