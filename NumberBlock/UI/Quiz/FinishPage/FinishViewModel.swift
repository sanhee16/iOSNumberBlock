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
    let wrongCnt: Int
    @Published var star: Int = 3
    let onClickButton: (FinishType)->()
    init(_ coordinator: AppCoordinator, wrongCnt: Int, onClickButton: @escaping (FinishType)->()) {
        self.wrongCnt = wrongCnt
        self.onClickButton = onClickButton
        super.init(coordinator)
    }
    
    func onAppear() {
        self.calcScore()
    }
    
    private func calcScore() {
        switch self.wrongCnt {
        case 0:
            self.star = 3
            break
        case 1..<3:
            self.star = 2
            break
        case 3..<5:
            self.star = 1
            break
        default:
            self.star = 0
            break
        }
    }
    
    func onClose() {
        self.dismiss()
    }
    
    func onClickNextStep() {
        self.onClickButton(.nextStep)
    }
    
    func onClickReset() {
        self.onClickButton(.reset)
    }
}
