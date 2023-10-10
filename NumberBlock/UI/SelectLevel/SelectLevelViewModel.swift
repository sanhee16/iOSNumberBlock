//
//  SelectLevelViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import Foundation
import Combine

class SelectLevelViewModel: BaseViewModel {
    @Published var list: [Level] = []
    
    let unit: Unit
    private let fetchLevelListUseCase: FetchLevelListUseCase
    init(_ coordinator: AppCoordinator, unit: Unit, fetchLevelListUseCase: FetchLevelListUseCase) {
        self.unit = unit
        self.fetchLevelListUseCase = fetchLevelListUseCase
        super.init(coordinator)
    }
    
    func onAppear() {
        self.getLevelList()
    }

    func getLevelList() {
        self.list = self.fetchLevelListUseCase.execute(idx: self.unit.idx)
    }
    
    func onClose() {
        self.dismiss()
    }
    
    func onClickLevel(_ level: Level) {
        if level.openTime == 0 {
            return
        }
        print("click! \(level.idx)")
    }
}

