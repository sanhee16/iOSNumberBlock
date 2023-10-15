//
//  Topbar.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import SwiftUI
import UIKit

enum TopbarType: String {
    case back = "chevron.backward"
    case close = "xmark"
    case none = ""
}

struct Topbar: View {
    static let PADDING: CGFloat = 14.0
    var title: String
    var type: TopbarType
    var textColor: Color
    var callback: (() -> Void)?
    
    init(_ title: String = "", type: TopbarType = .none, textColor: Color = Color.gray90, onTap: (() -> Void)? = nil) {
        self.title = title
        self.type = type
        self.callback = onTap
        self.textColor = textColor
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                if type != .none {
                    Image(systemName: type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(both: 16)
                        .padding(.leading, Self.PADDING)
                        .onTapGesture {
                            callback?()
                        }
                }
                Spacer()
            }
            Text(title)
                .font(.kr16b)
                .foregroundColor(textColor)
        }
        .frame(height: 50, alignment: .center)
    }
}
