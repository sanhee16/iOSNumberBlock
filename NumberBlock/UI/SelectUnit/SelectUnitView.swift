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
                Topbar("Unit 선택하기", type: .none, textColor: .black)
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
        return HStack(alignment: .center, spacing: 6) {
            if unit.openTime == 0 {
                Image(systemName: "lock.fill")
                    .scaledToFit()
                    .frame(both: 14.0)
            }
            
            Text("UNIT \(unit.idx + 1)")
                .font(.kr14r)
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
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
