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
    private let gridSpacing: CGFloat = 8.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Topbar("Unit \(vm.unit.idx + 1)", type: .back, textColor: .black) {
                    vm.onClose()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 1), count: 5), spacing: gridSpacing) {
                            ForEach($vm.list.wrappedValue.indices, id: \.self) { idx in
                                let level = $vm.list.wrappedValue[idx]
                                LevelItem(level: level, size: (geometry.size.width - gridSpacing * (5 + 1)) / 5)
                            }
                        }
                        .paddingHorizontal(gridSpacing)
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
        .environmentObject(vm)
    }
}

struct LevelItem: View {
    typealias VM = SelectLevelViewModel
    let level: Level
    let size: CGFloat
    @EnvironmentObject var vm: VM
    
    init(level: Level, size: CGFloat) {
        self.level = level
        self.size = size
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            if level.openTime == 0 {
                Image(systemName: "lock.fill")
                    .scaledToFit()
                    .frame(both: 14.0)
            }
            
            Text("\(level.idx + 1)")
                .font(.kr14r)
                .foregroundColor(.black)
        }
        .frame(both: self.size, aligment: .center)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(level.openTime == 0 ? .gray60 : .white)
        )
        .border(.gray90, lineWidth: 1.2, cornerRadius: 8)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 10))
        .onTapGesture {
            vm.onClickLevel(level)
        }
    }
}
