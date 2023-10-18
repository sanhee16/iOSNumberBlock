//
//  FinishViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/15.
//

import Foundation
import Combine
import SwiftUIPager
import SwiftUI

enum FinishType {
    case reset
    case nextStep
}

class FinishViewModel: BaseViewModel {
    @Published var score: Int = 3
    let onClickButton: (FinishType)->()
    init(_ coordinator: AppCoordinator, score: Int, onClickButton: @escaping (FinishType)->()) {
        self.score = score
        self.onClickButton = onClickButton
        super.init(coordinator)
    }
    
    func onAppear() {
        
    }
    
    func onClose() {
        self.dismiss()
    }
    
    func onClickButton(_ type: FinishType) {
        self.dismiss(animated: true) {[weak self] in
            self?.onClickButton(type)
        }
    }
}
