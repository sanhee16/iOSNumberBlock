//
//  FinishView.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/15.
//

import Foundation
import SwiftUI
import Lottie

struct FinishView: View {
    typealias VM = FinishViewModel
    
    public static func vc(_ coordinator: AppCoordinator, score: Int, onClickButton: @escaping (FinishType)->()) -> UIViewController {
        let vm = VM.init(coordinator, score: score, onClickButton: onClickButton)
        let view = Self.init(vm: vm)
        let vc = BaseViewController.init(view)
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor.clear
        vc.controller.view.backgroundColor = UIColor.dim
        return vc
    }
    
    @ObservedObject var vm: VM
    
    private var safeTop: CGFloat { get { Util.safeTop() }}
    private var safeBottom: CGFloat { get { Util.safeBottom() }}
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Topbar("", type: .close) {
                vm.onClose()
            }
            ZStack(alignment: .center) {
                LottieView(filename: "congratulations")
                    .frame(width: UIScreen.main.bounds.width - 60, height: 150, alignment: .center)
                    .zIndex(0)
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 12) {
                        ForEach(0..<3, id: \.self) { i in
                            Image(systemName: $vm.score.wrappedValue > i ? "star.fill" : "star")
                                .resizable()
                                .foregroundColor($vm.score.wrappedValue > i ? .yellow : .gray90)
                                .frame(both: 46.0)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 60, height: 100, alignment: .center)
                    Spacer()
                    HStack(alignment: .center, spacing: 10) {
                        Text("다시 풀기")
                            .font(.kr16r)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.gray30)
                                    .frame(width: (UIScreen.main.bounds.width - 60 - 30) / 2, height: 40, alignment: .center)
                            )
                            .frame(width: (UIScreen.main.bounds.width - 60 - 30) / 2, height: 40, alignment: .center)
                            .onTapGesture {
                                vm.onClickButton(.reset)
                            }
                        Text("다음 단계")
                            .font(.kr16r)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.primeColor1)
                                    .frame(width: (UIScreen.main.bounds.width - 60 - 30) / 2, height: 40, alignment: .center)
                            )
                            .frame(width: (UIScreen.main.bounds.width - 60 - 30) / 2, height: 40, alignment: .center)
                            .onTapGesture {
                                vm.onClickButton(.nextStep)
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width - 60, height: 40, alignment: .center)
                    .padding(top: 0, leading: 10, bottom: 10, trailing: 10)
                }
                .zIndex(1)
                .frame(width: UIScreen.main.bounds.width - 60, height: 180, alignment: .center)
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 180, alignment: .center)
        }
        .frame(width: UIScreen.main.bounds.width - 60, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
        )
        .onAppear {
            vm.onAppear()
        }
    }
}
