//
//  UseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import Foundation

protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
