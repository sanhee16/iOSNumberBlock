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
    
    public static func vc(_ coordinator: AppCoordinator, completion: (()-> Void)? = nil) -> UIViewController {
        let vm = VM.init(coordinator)
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
                Text("Quiz1")
                    .font(.kr26b)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                Pager(page: $vm.page.wrappedValue, data: $vm.quizItems.wrappedValue.indices, id: \.self) { idx in
                    let quizItem = $vm.quizItems.wrappedValue[idx]
                    QuizItemView(vm: vm, item: quizItem)
                }
                .allowsDragging(false)
                .background(Color.blue.opacity(0.2))
                Spacer()
                drawBottom(geometry)
                Spacer()
            }
            .frame(width: geometry.size.width, alignment: .center)
            .background(Color.green.opacity(0.3))
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
    
    private let blockSize: CGFloat = UIScreen.main.bounds.height / 19
    
    @ObservedObject var vm: VM
    var item: QuizData
    
    init(vm: VM, item: QuizData) {
        self.vm = vm
        self.item = item
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    HStack(alignment: .center, spacing: 20) {
                        drawBlockBox(item.block1, color: .green.opacity(0.4))
                        drawBlockBox(item.block2, color: .red.opacity(0.4))
                    }
                    Spacer()
                    drawAnswerBlockBox()
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
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .frame(width: geometry.size.width, alignment: .center)
        }
        .environmentObject(vm)
    }
    
    
    private func drawBlockBox(_ cnt: Int, color: Color) -> some View {
        return LazyVGrid(columns: Array(repeating: .init(.fixed(blockSize), spacing:  0.5), count: 2), spacing: 0.5) {
            ForEach(0..<10, id: \.self) { i in
                RoundedRectangle(cornerRadius: 10)
                    .frame(both: blockSize)
                    .foregroundColor(i < cnt ? color : .unSelected)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
        .border(.black.opacity(0.3), lineWidth: 3, cornerRadius: 20)
    }
    
    
    private func drawAnswerBlockBox() -> some View {
        return VStack(alignment: .center, spacing: 8) {
            LazyVGrid(columns: Array(repeating: .init(.fixed(blockSize), spacing:  0.5), count: 2), spacing: 0.5) {
                ForEach(0..<10, id: \.self) { idx in
                    let item = $vm.quizItems.wrappedValue[$vm.pageIdx.wrappedValue]
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                        if item.answerBlock[idx] {
                            Text("10")
                                .font(.kr16b)
                                .foregroundColor(.black)
                                .zIndex(1)
                        }
                    }
                    .frame(both: blockSize)
                    .foregroundColor(
                        item.answerBlock[idx] ? vm.setSelectedColor(idx) : .unSelected
                    )
                    .onTapGesture {
                        vm.onClickAnswerBlock(idx)
                    }
                }
            }
            Text("\($vm.quizItems.wrappedValue[$vm.pageIdx.wrappedValue].answerBlock.filter { $0 == true }.count)")
                .font(.kr20b)
            
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
        .border(.black.opacity(0.3), lineWidth: 3, cornerRadius: 20)
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(vm: QuizViewModel())
    }
}
