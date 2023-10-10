//
//  LevelStorage.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation
import RealmSwift

extension Level: Entity {
    private var storableLevel: LevelStorage {
        let realm = LevelStorage()
        realm.uuid = uuid
        realm.idx = idx
        realm.unitIdx = unitIdx
        realm.completeTime = completeTime
        realm.score = score
        return realm
    }
    
    func toStorable() -> LevelStorage {
        return storableLevel
    }
}

class LevelStorage: Object, Storable {
    @Persisted(primaryKey: true) var uuid: String = ""
    @Persisted var idx: Int
    @Persisted var unitIdx: Int
    @Persisted var completeTime: Int
    @Persisted var score: Int
    
    var model: Level {
        get {
            return Level(idx: idx, unitIdx: unitIdx, completeTime: completeTime, score: score)
        }
    }
}
