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


class QuizViewModel: BaseViewModel {
    @Published var page: Page = .withIndex(0)
    @Published var pageIdx: Int = 0
    @Published var quizList: [Quiz] = []
    @Published var enableMoveToBefore: Bool = false
    @Published var enableMoveToNext: Bool = true
    @Published var status: QuizScoreStatus = .none
    @Published var userAnswer: Int = 0
    
    let level: Level
    private let fetchQuizListUseCase: FetchQuizListUseCase
    
    init(_ coordinator: AppCoordinator, level: Level, fetchQuizListUseCase: FetchQuizListUseCase) {
        self.level = level
        self.fetchQuizListUseCase = fetchQuizListUseCase
        super.init(coordinator)
        self.fetchList()
    }
    
    func onAppear() {
        updateMoveButton()
    }
    
    func fetchList() {
        self.quizList = self.fetchQuizListUseCase.execute(idx: level.idx)
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
        if pageIdx == self.quizList.count - 1 {
            return
        }
        let currentQuiz = self.quizList[self.pageIdx]
//        print("cnt: \(self.quizList.count) // pageIdx: \(self.pageIdx)")
        if currentQuiz.isSolved {
            self.page.update(.move(increment: 1))
        } else {
            if currentQuiz.answer.num == self.userAnswer {
                self.quizList[self.pageIdx].isSolved = true
                self.updateStatus(.correct)
                self.page.update(.move(increment: 1))
            } else {
                self.updateStatus(.incorrect)
                return
            }
        }
        updateMoveButton()
    }
    
    func updateMoveButton() {
        self.userAnswer = 0
        self.pageIdx = page.index
        self.enableMoveToBefore = self.pageIdx > 0
        self.enableMoveToNext = self.pageIdx < self.quizList.count - 1
    }
    
    func isCorrectAnswer() -> Bool {
        let item = self.quizList[self.pageIdx]
        return userAnswer == item.answer.num
    }
    
    func onClickAnswerBlock(_ idx: Int) {
        switch self.userAnswer {
        case idx + 1:
            self.userAnswer -= 1
            return
        case idx:
            self.userAnswer += 1
            return
        default:
            return
        }
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
