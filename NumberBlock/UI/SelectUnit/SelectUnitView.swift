//
//  SelectUnitView.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import SwiftUI

struct SelectUnitView: View {
    typealias VM = SelectUnitViewModel
    public static func vc(_ coordinator: AppCoordinator, fetchUnitListUseCase: FetchUnitListUseCase, completion: (()-> Void)? = nil) -> UIViewController {
        let vm = VM.init(coordinator, fetchUnitListUseCase: fetchUnitListUseCase)
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
                ZStack(alignment: .center) {
                    Topbar("Unit 선택하기", type: .none, textColor: .black)
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(both: 20.0, aligment: .center)
                            .onTapGesture {
                                vm.onClickSetting()
                            }
                    }
                    .paddingHorizontal(Topbar.PADDING)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach($vm.list.wrappedValue.indices, id: \.self) { idx in
                            let unit = $vm.list.wrappedValue[idx]
                            unitItem(geometry, unit: unit)
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
    
    private func unitItem(_ geometry: GeometryProxy, unit: Unit) -> some View {
        return ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                if unit.openTime == 0 {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(both: 24.0)
                }
                Spacer()
            }
            .paddingLeading(16)
            HStack(alignment: .center, spacing: 6) {
                Spacer()
                VStack(alignment: .center, spacing: 4) {
                    Text(unit.title)
                        .font(.kr18r)
                        .foregroundColor(.black)
                    Text(unit.subTitle)
                        .font(.kr14r)
                        .foregroundColor(.gray60)
                    
                }
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .frame(width: geometry.size.width - 20, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(unit.openTime == 0 ? .gray60 : .white)
        )
        .border(.gray90, lineWidth: 1.2, cornerRadius: 8)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 10))
        .onTapGesture {
            vm.onClickUnit(unit)
        }
    }
}
