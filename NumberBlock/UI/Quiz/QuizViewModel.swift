//
//  QuizViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/09/18.
//

import Foundation
import Combine

class QuizViewModel: BaseViewModel {
    @Published var isShowAds: Bool = false
    
    override init(_ coordinator: AppCoordinator) {
        super.init(coordinator)
    }
    
    override init() {
        super.init()
    }
    
    func onAppear() {
        checkNetworkConnect()
    }
    
    func viewDidLoad() {
        
    }
}
