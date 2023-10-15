//
//  SettingView.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/15.
//

import SwiftUI

struct SettingView: View {
    typealias VM = SettingViewModel
    public static func vc(_ coordinator: AppCoordinator, setAdminUseCase: SetAdminUseCase, settingUseCase: SettingUseCase, completion: (()-> Void)? = nil) -> UIViewController {
        let vm = VM.init(coordinator, setAdminUseCase: setAdminUseCase, settingUseCase: settingUseCase)
        let view = Self.init(vm: vm)
        let vc = BaseViewController.init(view, completion: completion)
        return vc
    }
    @ObservedObject var vm: VM
    
    private var safeTop: CGFloat { get { Util.safeTop() }}
    private var safeBottom: CGFloat { get { Util.safeBottom() }}
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Topbar("설정", type: .back, textColor: .black) {
                    vm.onClose()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        drawSettingItem("관리자 모드") {
                            vm.onClickAdminMode()
                        }
                        
                        drawSettingItem("초기화 하기") {
                            vm.onClickReset()
                        }
                            
                    }
                    .padding(top: 10, leading: 0, bottom: 20, trailing: 0)
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: safeTop, leading: 0, bottom: safeBottom, trailing: 0))
            .edgesIgnoringSafeArea(.all)
            .frame(width: geometry.size.width, alignment: .center)
        }
        .onAppear {
            vm.onAppear()
        }
    }
    
    func drawSettingItem(_ title: String, description: String? = nil, onTap: @escaping () -> ()) -> some View {
        return VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 4) {
                    Text(title)
                        .font(.kr18r)
                        .foregroundColor(.black)
                    if let description = description {
                        Text(description)
                            .font(.kr15r)
                            .foregroundColor(.gray60)
                    }
                }
                Spacer()
            }
            .paddingVertical(10)
            Divider()
        }
        .paddingHorizontal(16)
        .onTapGesture {
            onTap()
        }
    }
}
