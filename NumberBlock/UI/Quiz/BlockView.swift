//
//  BlockView.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/13.
//

import Foundation
import SwiftUI

struct QuestionBlock: View {
    private let blockSize: CGFloat = UIScreen.main.bounds.height / 18
    var block: Int
    
    init(block: Int) {
        self.block = block
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            LazyHGrid(rows: Array(repeating: .init(.fixed(blockSize), spacing: 0.5), count: 5), spacing: 0.5) {
                ForEach(0..<10, id: \.self) { idx in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(both: blockSize)
                        .foregroundColor(idx < block ? QuizAnswer(rawValue: block)?.selectedColor : .unSelected)
                }
            }
            .fixedSize()
            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
        .border(.black.opacity(0.3), lineWidth: 3, cornerRadius: 20)
    }
}

struct AnswerBlock: View {
    typealias VM = QuizViewModel
    private let blockSize: CGFloat = UIScreen.main.bounds.height / 19
    
    @State var userAnswer: Int
    
    var block1: Block
    var block2: Block
    let answer: Int
    var onTap: (Int, Int) -> ()
    
    init(userAnswer: Int, block1: Block, block2: Block, onTap: @escaping (Int, Int) -> Void) {
        print("INIT: \(block1.num) // \(block2.num)")
        self.userAnswer = userAnswer
        self.block1 = block1
        self.block2 = block2
        self.onTap = onTap
        self.answer = block1.num + block2.num
    }
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if self.answer > 100 {
                drawBlock(100)
            }
            if self.answer > 10 {
                drawBlock(10)
            }
            drawBlock(1)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
        .border(.black.opacity(0.3), lineWidth: 3, cornerRadius: 20)
    }
    
    private func drawBlock(_ unit: Int) -> some View {
        let cnt = $userAnswer.wrappedValue % unit
        return VStack(alignment: .center, spacing: 8) {
            LazyHGrid(rows: Array(repeating: .init(.fixed(blockSize), spacing:  0.5), count: 5), spacing: 0.5) {
                ForEach(0..<10, id: \.self) { idx in
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                        Text("\(unit)")
                            .font(.kr16b)
                            .foregroundColor(.black)
                            .zIndex(1)
                    }
                    .frame(both: blockSize)
                    .foregroundColor(
                        idx < cnt ? QuizAnswer(rawValue: cnt)?.selectedColor : .unSelected
                    )
                    .id(idx)
                    .onTapGesture {
                        onTap(idx, unit)
                    }
                }
            }
            Text("\(cnt * unit)")
                .font(.kr20b)
        }
    }
}
