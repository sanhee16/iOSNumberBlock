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
        realm.title = title
        realm.subTitle = subTitle
        realm.openTime = openTime
        realm.completeTime = completeTime
        return realm
    }
    
    func toStorable() -> UnitStorage {
        return storableUnit
    }
}

class UnitStorage: Object, Storable {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var idx: Int //idx, 순서
    @Persisted var title: String
    @Persisted var subTitle: String
    @Persisted var openTime: Int // epochTime
    @Persisted var completeTime: Int // epochTime
    
    var model: Unit {
        get {
            return Unit(uuid: uuid, idx: idx, title: title, subTitle: subTitle, openTime: openTime, completeTime: completeTime)
        }
    }
}
