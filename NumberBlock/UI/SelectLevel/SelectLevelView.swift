//
//  SelectLevelView.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/09.
//

import SwiftUI

struct SelectLevelView: View {
    typealias VM = SelectLevelViewModel
    public static func vc(_ coordinator: AppCoordinator, unit: Unit, fetchLevelListUseCase: FetchLevelListUseCase, completion: (()-> Void)? = nil) -> UIViewController {
        let vm = VM.init(coordinator, unit: unit, fetchLevelListUseCase: fetchLevelListUseCase)
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
                Topbar("Unit \(vm.unit.idx + 1)", type: .back, textColor: .black) {
                    vm.onClose()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach($vm.list.wrappedValue.indices, id: \.self) { idx in
//                            let unit = $vm.list.wrappedValue[idx]
//                            unitItem(geometry, unit: unit)
                        }
                    }
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
        
    }
}
