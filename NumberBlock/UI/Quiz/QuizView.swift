//
//  QuizView.swift
//  NumberBlock
//
//  Created by sandy on 2023/09/18.
//

import Foundation
import SwiftUI
import SwiftUIPager

struct QuizView: View {
    typealias VM = QuizViewModel
    
    public static func vc(_ coordinator: AppCoordinator, level: Level, fetchQuizListUseCase: FetchQuizListUseCase, completion: (()-> Void)? = nil) -> UIViewController {
        let vm = VM.init(coordinator, level: level, fetchQuizListUseCase: fetchQuizListUseCase)
        let view = Self.init(vm: vm)
        
        let vc = BaseViewController.init(view, completion: completion) {
            vm.viewDidLoad()
        }
        return vc
    }
    
    @ObservedObject var vm: VM
    
    private var safeTop: CGFloat { get { Util.safeTop() }}
    private var safeBottom: CGFloat { get { Util.safeBottom() }}
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                ZStack(alignment: .center) {
                    Topbar(vm.level.title, type: .back, textColor: .black) {
                        vm.onClose()
                    }
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Image(systemName: "lightbulb.fill")
                            .resizable()
                            .frame(width: 14.0, height: 20.0, alignment: .center)
                            .foregroundColor(Color.yellow)
                            .onTapGesture {
                                vm.onClickHint()
                            }
                    }
                    .paddingHorizontal(Topbar.PADDING)
                }
                
                Pager(page: $vm.page.wrappedValue, data: $vm.quizList.wrappedValue.indices, id: \.self) { idx in
                    let quizItem = $vm.quizList.wrappedValue[idx]
                    QuizItemView(vm: vm, item: quizItem)
                }
                .allowsDragging(false)
                Spacer()
                drawBottom(geometry)
                Spacer()
            }
            .frame(width: geometry.size.width, alignment: .center)
        }
        .onAppear {
            vm.onAppear()
        }
    }
    
    private func drawBottom(_ geometry: GeometryProxy) -> some View {
        return HStack(alignment: .center, spacing: 0) {
            Spacer()
            bottomButton(geometry, text: "이전", enable: $vm.enableMoveToBefore.wrappedValue) {
                vm.onClickMoveBefore()
            }
            Spacer()
            bottomButton(geometry, text: "다음", enable: $vm.enableMoveToNext.wrappedValue) {
                vm.onClickMoveNext()
            }
            Spacer()
        }
    }
    
    private func bottomButton(_ geometry: GeometryProxy, text: String, enable: Bool, onClick: @escaping ()->()) -> some View {
        return Text(text)
            .font(.kr20b)
            .foregroundColor(.black)
            .frame(width: (geometry.size.width - 40) / 2, height: 50, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(enable ? .primeColor2 : .inputBoxColor)
            )
            .onTapGesture {
                if enable {
                    onClick()
                }
            }
    }
}

struct QuizItemView: View {
    typealias VM = QuizViewModel
    
    private let blockSize: CGFloat = UIScreen.main.bounds.height / 18
    
    @ObservedObject var vm: VM
    var item: Quiz
    
    init(vm: VM, item: Quiz) {
        self.vm = vm
        self.item = item
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    HStack(alignment: .center, spacing: 20) {
                        if item.block1 >= 0 {
                            QuestionBlock(block: item.block1)
                        }
                        if item.block2 >= 0 {
                            QuestionBlock(block: item.block2)
                        }
                    }
                    .paddingBottom(20)
                    
                    drawAnswerBlock(item)
                    Spacer()
                }
                if let imageName = $vm.status.wrappedValue.imageName {
                    withAnimation {
                        Image(imageName)
                            .resizable()
                            .frame(both: geometry.size.width - 100)
                            .opacity(0.7)
                            .zIndex(1)
                    }
                }
            }
            .padding(top: 10, leading: 20, bottom: 10, trailing: 20)
            .frame(width: geometry.size.width, alignment: .center)
        }
        .environmentObject(vm)
    }
    
    private func drawAnswerBlock(_ quiz: Quiz) -> some View {
        return HStack(alignment: .center, spacing: 18) {
            Spacer()
            if item.answer > 100 {
                drawBlock(100, quiz: quiz)
            }
            if item.answer > 10 {
                drawBlock(10, quiz: quiz)
            }
            drawBlock(1, quiz: quiz)
            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
        .border(.black.opacity(0.3), lineWidth: 3, cornerRadius: 20)
    }
    
    private func drawBlock(_ unit: Int, quiz: Quiz) -> some View {
        //TODO: 여기 로직 고쳐야됨 ㅠㅠ
        
        let cnt = (($vm.userAnswer.wrappedValue % (unit * 10)) / unit)
        let answer = ((quiz.answer % (unit * 10)) / unit)
        return VStack(alignment: .center, spacing: 8) {
            LazyHGrid(rows: Array(repeating: .init(.fixed(blockSize), spacing:  0.5), count: 5), spacing: 0.5) {
                ForEach(0..<10, id: \.self) { idx in
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                        Text("\(unit)")
                            .font(.kr16b)
                            .foregroundColor(.black)
                            .zIndex(2)
                    }
                    .frame(both: blockSize)
                    .foregroundColor(
                        $vm.isBlinking.wrappedValue
                        ? idx < answer ? QuizAnswer(rawValue: answer)?.selectedColor.opacity(0.4) : .unSelected
                        : idx < cnt ? QuizAnswer(rawValue: cnt)?.selectedColor : .unSelected
                    )
                    .id(idx)
                    .onTapGesture {
                        if !$vm.isHinting.wrappedValue {
                            vm.onClickAnswerBlock(idx, unit: unit)
                        }
                    }
                }
            }
            Text($vm.isHinting.wrappedValue ? " " : "\(cnt * unit)")
                .font(.kr20b)
        }
    }
}

//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView(vm: QuizViewModel())
//    }
//}
