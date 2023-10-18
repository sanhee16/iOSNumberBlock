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
    private var pageIdx: Int = 0
    @Published var quizList: [Quiz] = []
    @Published var enableMoveToBefore: Bool = false
    @Published var enableMoveToNext: Bool = true
    
    @Published var status: QuizScoreStatus = .none
    @Published var userAnswer: Int = 0
    var hintingCount: Int = 0
    @Published var isHinting: Bool = false
    @Published var isBlinking: Bool = false
    var wrongCnt: Int = 0
    var wrongPage: Set<Int> = []
    
    var level: Level
    private let fetchQuizListUseCase: FetchQuizListUseCase
    private let solveQuizUseCase: SolveQuizUseCase
    
    init(_ coordinator: AppCoordinator, level: Level, fetchQuizListUseCase: FetchQuizListUseCase, solveQuizUseCase: SolveQuizUseCase) {
        self.level = level
        self.fetchQuizListUseCase = fetchQuizListUseCase
        self.solveQuizUseCase = solveQuizUseCase
        super.init(coordinator)
        self.fetchList()
    }
    
    func onAppear() {
        updateMoveButton()
    }
    
    func onClose() {
        self.dismiss()
    }
    
    func fetchList() {
        self.quizList = self.fetchQuizListUseCase.execute(idx: level.idx)
    }
    
    func viewDidLoad() {
        
    }
    
    func updatePage(_ move: Int) {
        self.page.update(.move(increment: move))
        self.updateMoveButton()
    }
    
    func onClickMoveBefore() {
        if pageIdx == 0 {
            return
        }
        self.updatePage(-1)
    }
    
    func onClickMoveNext() {
        let score = self.calcScore(self.wrongCnt)
        self.coordinator?.presentFinishView(score) {[weak self] type in
            guard let self = self else { return }
            switch type {
            case .nextStep:
                self.solveQuizUseCase.execute(self.level.idx, score: score)
                //TODO: 다음 레벨!
                self.dismiss()
                break
            case .reset:
                self.quizList.indices.forEach { idx in
                    self.quizList[idx].isSolved = false
                }
                self.updatePage(0)
                break
            }
        }
        return
        
//        if (pageIdx == self.quizList.count - 1) {
//            // 마지막
//            self.coordinator?.presentFinishView(self.wrongCnt) {[weak self] type in
//                self?.dismiss()
//            }
//            return
//        }
        
        let currentQuiz = self.quizList[self.pageIdx]
        if currentQuiz.isSolved {
            self.updatePage(1)
        } else {
            if currentQuiz.answer == self.userAnswer {
                self.quizList[self.pageIdx].isSolved = true
                self.updateStatus(.correct)
                self.updatePage(1)
            } else {
                self.updateStatus(.incorrect)
                self.wrongCnt += 1
                self.wrongPage.insert(currentQuiz.idx)
                return
            }
        }
    }
    
    func updateMoveButton() {
        self.userAnswer = 0
        self.pageIdx = page.index
        self.enableMoveToBefore = self.pageIdx > 0
//        self.enableMoveToNext = self.pageIdx < self.quizList.count - 1
    }
    
    func onClickAnswerBlock(_ idx: Int, unit: Int) {
        switch (self.userAnswer % (unit * 10)) / unit {
        case idx + 1:
            self.userAnswer -= (1 * unit)
            print("userAnswer: \(userAnswer)")
            return
        case idx:
            self.userAnswer += (1 * unit)
            print("userAnswer: \(userAnswer)")
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
    
    func onClickHint() {
        if self.isHinting {
            return
        }
        self.isHinting = true
        withAnimation {
            self.isBlinking = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            withAnimation {
                self?.isBlinking = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isHinting = false
        }
    }
    
    private func calcScore(_ wrongCnt: Int) -> Int {
        switch wrongCnt {
        case 0:
            return 3
        case 1..<3:
            return 2
        case 3..<5:
            return 1
        default:
            return 0
        }
    }
}
