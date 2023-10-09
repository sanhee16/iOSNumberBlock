//
//  UnitStorage.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation
import RealmSwift

extension Unit: Entity {
    private var storableUnit: UnitStorage {
        let realm = UnitStorage()
        realm.uuid = uuid
        realm.idx = idx
        realm.complete = complete
        return realm
    }
    
    func toStorable() -> UnitStorage {
        return storableUnit
    }
}

class UnitStorage: Object, Storable {
    @Persisted(primaryKey: true) var uuid: String = ""
    @Persisted var idx: Int //idx, 순서
    @Persisted var complete: Int // epochTime
    
    var model: Unit {
        get {
            return Unit(uuid: uuid, idx: idx, complete: complete)
        }
    }
}
