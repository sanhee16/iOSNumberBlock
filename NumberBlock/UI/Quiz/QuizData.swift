//
//  QuizData.swift
//  NumberBlock
//
//  Created by sandy on 2023/09/18.
//

import Foundation
import SwiftUI

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
