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
    var uuid: String
    var idx: Int // idx, 순서
    var title: String
    var subTitle: String
    var openTime: Int = 0 // 처음 열린 시간
    var completeTime: Int = 0 // epochTime
}
