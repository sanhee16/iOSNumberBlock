//
//  DownloadDBUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/13.
//

import Foundation
import Combine


protocol DownloadDBUseCase {
    func execute(
        //        requestValue: InitalizeDBUseCaseRequestValue,
        completion: @escaping () -> ()
    )
}

final class DefaultDownloadDBUseCase: DownloadDBUseCase {
    private let fireStorageService: FireStorageService
    private var subscription = Set<AnyCancellable>()
    
    init(
        fireStorageService: FireStorageService
    ) {
        self.fireStorageService = fireStorageService
    }
    
    func execute(
        completion: @escaping () -> ()
    ) {
        Publishers.Zip3(
            fireStorageService.downloadFile("unit.csv"),
            fireStorageService.downloadFile("level.csv"),
            fireStorageService.downloadFile("quiz.csv")
        )
        .run(in: &self.subscription) { (_, _, _) in
            completion()
        } err: { err in
            print("download Failed!")
        } complete: {
            
        }
    }
    
    deinit {
        subscription.removeAll()
    }
}
