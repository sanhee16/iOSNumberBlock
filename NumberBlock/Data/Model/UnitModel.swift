//
//  UnitModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/04.
//

import Foundation

struct Unit: Equatable, Hashable, Codable {
    static func == (lhs: Unit, rhs: Unit) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    var uuid: String = UUID().uuidString
    var idx: Int // idx, 순서
    var complete: Int // epochTime
}
