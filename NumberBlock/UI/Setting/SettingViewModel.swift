//
//  SettingViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/15.
//

import Foundation
import Combine

class SettingViewModel: BaseViewModel {
    private let setAdminUseCase: SetAdminUseCase
    private let settingUseCase: SettingUseCase
    @Published var list: [Unit] = []
    @Published var isLoading: Bool = false
    
    init(_ coordinator: AppCoordinator, setAdminUseCase: SetAdminUseCase, settingUseCase: SettingUseCase) {
        self.setAdminUseCase = setAdminUseCase
        self.settingUseCase = settingUseCase
        super.init(coordinator)
    }
    
    func onAppear() {
        
    }
    
    func onClose() {
        self.dismiss()
    }
    
    func onClickAdminMode() {
        if isLoading {
            return
        }
        isLoading = true
        setAdminUseCase.execute {[weak self] in
            self?.isLoading = false
        }
    }
    
    func onClickReset() {
        if isLoading {
            return
        }
        isLoading = true
        settingUseCase.resetAll {[weak self] in
            self?.isLoading = false
            print("complete")
        }
    }
}
