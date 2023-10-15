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
    let initalizeDBUseCase: InitalizeDBUseCase
    let fetchUnitListUseCase: FetchUnitListUseCase
    let fetchLevelListUseCase: FetchLevelListUseCase
    let fetchQuizListUseCase: FetchQuizListUseCase
    let setAdminUseCase: SetAdminUseCase
    let settingUseCase: SettingUseCase
    
    
    let unitRepository: UnitRepository = UnitRepository()
    let levelRepository: LevelRepository = LevelRepository()
    let quizRepository: QuizRepository = QuizRepository()
    
    let fireStorageService: FireStorageService = FireStorageService()
    
    let downloadDBUseCase: DownloadDBUseCase
    private init() {
        self.initalizeDBUseCase = DefaultInitalizeDBUseCase(
            unitRepository: self.unitRepository,
            levelRepository: self.levelRepository,
            quizRepository: self.quizRepository
        )
        self.fetchUnitListUseCase = FetchUnitListUseCase(unitRepository: self.unitRepository)
        self.fetchLevelListUseCase = FetchLevelListUseCase(levelRepository: self.levelRepository)
        self.fetchQuizListUseCase = FetchQuizListUseCase(quizRepository: self.quizRepository)
        self.setAdminUseCase = DefaultSetAdminUseCase(unitRepository: self.unitRepository, levelRepository: self.levelRepository, quizRepository: self.quizRepository)
        self.settingUseCase = DefaultSettingUseCase(unitRepository: self.unitRepository, levelRepository: self.levelRepository, quizRepository: self.quizRepository)
        self.downloadDBUseCase = DefaultDownloadDBUseCase(fireStorageService: self.fireStorageService)
    }
}
