//
//  MainViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2022/10/05.
//

import Foundation
import Combine

class MainViewModel: BaseViewModel {
//    @Published var currentTab: MainMenuType = .map
    @Published var isShowAds: Bool = false
    
    override init(_ coordinator: AppCoordinator) {
        super.init(coordinator)
//        Remote.init().getIsShowAds({[weak self] value in
//            DispatchQueue.main.async {
//                self?.isShowAds = value
//                print("isShowAds: \(String(describing: self?.isShowAds))")
//            }
//        })
    }
    
    func onAppear() {
        checkNetworkConnect()
    }
    
    func viewDidLoad() {
        
    }
    
//    func onClickTab(_ tab: MainMenuType) {
//        self.currentTab = tab
//    }
}
