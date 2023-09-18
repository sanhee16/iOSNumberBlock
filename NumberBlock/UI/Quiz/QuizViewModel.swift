//
//  QuizViewModel.swift
//  NumberBlock
//
//  Created by sandy on 2023/09/18.
//

import Foundation
import Combine
import SwiftUIPager
import SwiftUI

enum QuizScoreStatus {
    case correct
    case incorrect
    case none
    
    var imageName: String? {
        switch self {
        case .correct: return "correct"
        case .incorrect: return "incorrect"
        case .none: return nil
        }
    }
}

class QuizViewModel: BaseViewModel {
    @Published var page: Page = .withIndex(0)
    @Published var pageIdx: Int = 0
    @Published var quizItems: [QuizData] = []
    @Published var enableMoveToBefore: Bool = false
    @Published var enableMoveToNext: Bool = true
    @Published var status: QuizScoreStatus = .none
    
    
    override init(_ coordinator: AppCoordinator) {
        super.init(coordinator)
        self.makeDummy()
    }
    
    override init() {
        super.init()
        self.makeDummy()
    }
    
    private func makeDummy() {
        let dummy: [QuizData] = [
            QuizData(max: 10, block1: 3, block2: 1, isSolved: false),
            QuizData(max: 10, block1: 1, block2: 2, isSolved: false),
            QuizData(max: 10, block1: 5, block2: 5, isSolved: false),
            QuizData(max: 10, block1: 7, block2: 6, isSolved: false),
            QuizData(max: 10, block1: 9, block2: 8, isSolved: false),
            QuizData(max: 10, block1: 10, block2: 2, isSolved: false),
            QuizData(max: 10, block1: 2, block2: 3, isSolved: false)
        ]
        self.quizItems = dummy
    }
    
    func onAppear() {
        checkNetworkConnect()
        updateMoveButton()
    }
    
    func viewDidLoad() {
        
    }
    
    func onClickMoveBefore() {
        if pageIdx == 0 {
            return
        }
        self.page.update(.move(increment: -1))
        updateMoveButton()
    }
    
    func onClickMoveNext() {
        if pageIdx == self.quizItems.count - 1 {
            return
        }
        let item = self.quizItems[self.pageIdx]
        if item.isSolved {
            self.page.update(.move(increment: 1))
        } else {
            if onCorrectAnswer() {
                self.quizItems[self.pageIdx].isSolved = true
                self.updateStatus(.correct) {
                    self.onClickMoveNext()
                }
                return
            } else {
                self.updateStatus(.incorrect)
                return
            }
        }
        updateMoveButton()
    }
    
    func updateMoveButton() {
        self.pageIdx = page.index
        self.enableMoveToBefore = self.pageIdx > 0
        self.enableMoveToNext = self.pageIdx < self.quizItems.count - 1
    }
    
    func onCorrectAnswer() -> Bool {
        let item = self.quizItems[self.pageIdx]
        var userAnswer: Int = 0
        let answer: Int = item.block1 + item.block2
        for ans in item.answerBlock {
            userAnswer += (ans == true ? 1 : 0)
        }
        return answer == userAnswer
    }
    
    func onClickAnswerBlock(_ idx: Int) {
        self.quizItems[self.pageIdx].answerBlock[idx] = !self.quizItems[self.pageIdx].answerBlock[idx]
    }
    
    func updateStatus(_ status: QuizScoreStatus, onComplete: (()->())? = nil) {
        self.status = status
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else { return }
            self.status = .none
            onComplete?()
        }
    }
}
