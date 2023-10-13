//
//  QuizData.swift
//  NumberBlock
//
//  Created by sandy on 2023/09/18.
//

import Foundation
import SwiftUI

/*
 🔸️1단 (두 수의 합이 4이하)
 1+1, 1+2, 2+2, 3+1, 1+3, 2+1

 🔹️2단(5별에 +1, +2, +3, +4, +5)
 5+1, 5+2, 5+3, 5+4, 5+5
 
 🔸️3단계 (두 수의 합이 4이하)
 1+1, 1+2, 2+2, 3+1, 1+3, 2+1

 🔹️4단계(5에 +1, +2, +3, +4, +5)
 5+1, 5+2, 5+3, 5+4, 5+5

 🔸️5단계 (5만들기)
 1+4, 2+3, 3+2, 4+1

 🔹️6단계(작은동수 더하기)
 1+1, 2+2, 3+3, 4+4, 5+5

 🔸️7단계(큰 동수 더하기)
 6+6, 7+7, 8+8, 9+9, 10+10
 
 */
enum QuizAnswer: Int {
    case no1 = 1
    case no2 = 2
    case no3 = 3
    case no4 = 4
    case no5 = 5
    case no6 = 6
    case no7 = 7
    case no8 = 8
    case no9 = 9
    case no10 = 10
    
    var selectedColor: Color {
        switch self {
        case .no1: return .no1
        case .no2: return .no2
        case .no3: return .no3
        case .no4: return .no4
        case .no5: return .no5
        case .no6: return .no6
        case .no7: return .no7
        case .no8: return .no8
        case .no9: return .no9
        case .no10: return .no10
        }
    }
}


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
