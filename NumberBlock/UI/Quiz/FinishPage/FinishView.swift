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
    
    public static func vc(_ coordinator: AppCoordinator, wrongCnt: Int, completion: (()-> Void)? = nil) -> UIViewController {
        let vm = VM.init(coordinator, wrongCnt: wrongCnt)
        let view = Self.init(vm: vm)
        let vc = BaseViewController.init(view, completion: completion)
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
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 12) {
                        ForEach(0..<3, id: \.self) { i in
                            Image(systemName: $vm.star.wrappedValue > i ? "star.fill" : "star")
                                .resizable()
                                .foregroundColor($vm.star.wrappedValue > i ? .yellow : .gray90)
                                .frame(both: 46.0)
                        }
                    }
                    .zIndex(1)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 100, alignment: .center)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 60, height: 150, alignment: .center)
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 150, alignment: .center)
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
