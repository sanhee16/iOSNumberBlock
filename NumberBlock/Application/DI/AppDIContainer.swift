//
//  AppDIContainer.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation
import UIKit

final class AppDIContainer {
    static let shared: AppDIContainer = AppDIContainer()
    let unitRepository: UnitRepository
    
    private init() {
        self.unitRepository = UnitRepository()
    }
}
