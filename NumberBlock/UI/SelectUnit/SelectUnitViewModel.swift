//
//  SelectUnitViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation
import Combine

class SelectUnitViewModel: BaseViewModel {
    private let unitRepository: UnitRepository
    @Published var list: [Unit] = []
    
    init(_ coordinator: AppCoordinator, unitRepository: UnitRepository) {
        self.unitRepository = unitRepository
        super.init(coordinator)
    }
    
    func onAppear() {
        getUnitList()
    }

    func getUnitList() {
        self.list = self.unitRepository.getAll()
    }
    
    func onClickUnit(_ unit: Unit) {
        guard let idx = self.list.lastIndex(of: unit) else { return }
        if (unit.openTime > 0) || (list[idx - 1].completeTime > 0) {
            // Present Select Level
            print("present unit \(unit.idx + 1)")
            return
        }
        return
    }
    
}
