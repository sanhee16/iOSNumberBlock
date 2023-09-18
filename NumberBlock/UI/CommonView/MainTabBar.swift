////
////  MainTabBar.swift
////  NumberBlock
////
////  Created by sandy on 2023/06/04.
////
//
//import Foundation
//import SwiftUI
//
//public struct MainMenuElements {
//    var current: MainMenuType
//    var onClick: ((MainMenuType)->())?
//}
//
//public enum MainMenuType: Int, Equatable {
//    case map
//    case NumberBlocks
//    case travel
//    case favorite
//    case setting
//    
//    var onImage: String {
//        switch self {
//        case .map: return "map_on"
//        case .NumberBlocks: return "list_on"
//        case .travel: return "travel_on"
//        case .favorite: return "favorite_on"
//        case .setting: return "setting_on"
//        }
//    }
//    
//    var offImage: String {
//        switch self {
//        case .map: return "map_off"
//        case .NumberBlocks: return "list_off"
//        case .travel: return "travel_off"
//        case .favorite: return "favorite_off"
//        case .setting: return "setting_off"
//        }
//    }
//    
//    var text: String {
//        switch self {
//        case .map: return "map".localized()
//        case .NumberBlocks: return "NumberBlocks".localized()
//        case .travel: return "travel".localized()
//        case .favorite: return "favorite".localized()
//        case .setting: return "setting".localized()
//        }
//    }
//    
//    var viewName: String {
//        switch self {
//        case .map: return String(describing: MainView.self)
//        case .NumberBlocks: return String(describing: NumberBlockListView.self)
//        case .travel: return String(describing: TravelListView.self)
//        case .favorite: return String(describing: TravelListView.self)
//        case .setting: return String(describing: SettingView.self)
//        }
//    }
//}
//
//public struct MainTabBar: View {
//    private var current: MainMenuType
//    private var onClick: ((MainMenuType)->())?
//    private let geometry: GeometryProxy
//    private let ICON_SIZE: CGFloat = 38.0
//    private let ITEM_WIDTH: CGFloat = UIScreen.main.bounds.width / 4
//    private let ITEM_HEIGHT: CGFloat = 60.0
//    private let list: [MainMenuType] = [.map, .NumberBlocks, .travel, .setting]
//    
//    init(geometry: GeometryProxy, current: MainMenuType, onClick: ((MainMenuType)->())?) {
//        self.geometry = geometry
//        self.current = current
//        self.onClick = onClick
//    }
//    
//    public var body: some View {
//        HStack(alignment: .center, spacing: 0) {
//            ForEach(self.list.indices, id: \.self) { idx in
//                drawItem(self.list[idx], isSelected: self.list[idx] == self.current)
//            }
//        }
//        .background(Color.backgroundColor)
//    }
//    
//    private func drawItem(_ item: MainMenuType, isSelected: Bool) -> some View {
//        return VStack(alignment: .center, spacing: 0) {
//            Image(isSelected ? item.onImage : item.offImage)
//                .resizable()
//                .scaledToFit()
//                .frame(both: ICON_SIZE, aligment: .center)
//            Text(item.text)
//                .font(isSelected ? .kr10b : .kr10r)
//                .foregroundColor(isSelected ? .fColor3 : .textColor1)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {
//            switch item {
//            case .map: self.onClick?(.map)
//            case .NumberBlocks: self.onClick?(.NumberBlocks)
//            case .travel: self.onClick?(.travel)
//            case .favorite: self.onClick?(.favorite)
//            case .setting: self.onClick?(.setting)
//            }
//        }
//        .frame(width: ITEM_WIDTH, height: ITEM_HEIGHT, alignment: .center)
//    }
//}
//
//
//
//
