//
//  SwiftUIExtension.swift
//  NumberBlock
//
//  Created by sandy on 2023/06/03.
//

import SwiftUI
import Combine

extension View {
    public func padding(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> some View {
        return self.padding(EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    public func paddingTop(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: value, leading: 0, bottom: 0, trailing: 0))
    }
    public func paddingLeading(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: value, bottom: 0, trailing: 0))
    }
    public func paddingTrailing(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: value))
    }
    public func paddingBottom(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: 0, bottom: value, trailing: 0))
    }
    public func paddingHorizontal(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: value, bottom: 0, trailing: value))
    }
    public func paddingVertical(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: value, leading: 0, bottom: value, trailing: 0))
    }
    
    
    
    public func border(_ color: Color, lineWidth: CGFloat, cornerRadius: CGFloat) -> some View {
        return self
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth).foregroundColor(color))
    }
    
    public func frame(both: CGFloat, aligment: Alignment = .center) -> some View {
        return self
            .frame(width: both, height: both, alignment: aligment)
    }
    
    func rectReader(_ binding: Binding<CGRect>, in space: CoordinateSpace) -> some View {
        self.background(GeometryReader { (geometry) -> AnyView in
            let rect = geometry.frame(in: space)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
            }
            return AnyView(Rectangle().fill(Color.clear))
        })
    }
}

extension Color {
    init(hex string: String, opacity: CGFloat? = nil) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }
        
        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }
        
        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }
        
        // Scanner creation
        let scanner = Scanner(string: string)
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        if string.count == 2 {
            let mask = 0xFF
            let g = Int(color) & mask
            let gray = Double(g) / 255.0
            
            
            if let opacity = opacity {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: opacity)
            } else {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
            }
        } else if string.count == 4 {
            let mask = 0x00FF
            
            let g = Int(color >> 8) & mask
            let a = Int(color) & mask
            
            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0
            
            if let opacity = opacity {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: opacity)
            } else {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
            }
        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            
            if let opacity = opacity {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
            } else {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
            }
            
        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask
            
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0
            
            if let opacity = opacity {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
            } else {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
            }
            
        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
    
//    func hexToString() -> String {
//        let r: CGFloat = 0
//        let g: CGFloat = 0
//        let b: CGFloat = 0
//        let a: CGFloat = 0
//
//        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
//
//        return String(format: "#%06x", rgb)
//    }
    
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if a != Float(1.0) {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    func toTravelBackground() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(0.5)

        if String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)) == "#FFFFFF" {
            // white이면 그냥 alpha없이 return
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
        if a != Float(1.0) {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    var uiColor: UIColor {
        get { UIColor(cgColor: cgColor!) }
    }
    
    public static let backgroundColor: Color = Color(hex: "#F3F6FB")
    public static let inputBoxColor: Color = Color(hex: "#DADADA")
    
    //MARK: primeColor
    public static let no1: Color = Color(hex: "#d00000").opacity(0.75) // 빨강
    public static let no2: Color = Color(hex: "#ffbe0b").opacity(0.75) // 노랑
    public static let no3: Color = Color(hex: "#4361ee").opacity(0.75) // 파랑
    public static let no4: Color = Color(hex: "#fb6f92").opacity(0.75) // 핑크
    public static let no5: Color = Color(hex: "#fb6107").opacity(0.75) // 주황
    public static let no6: Color = Color(hex: "#6fffe9").opacity(0.75) // 민트
    public static let no7: Color = Color(hex: "#7209b7").opacity(0.75) // 보라
    public static let no8: Color = Color(hex: "#70e000").opacity(0.75) // 초록
    public static let no9: Color = Color(hex: "#caf0f8").opacity(0.75) // 하늘
    public static let no10: Color = Color(hex: "#774936").opacity(0.75) // 갈색
    
    public static let selected: Color = Color(hex: "#8FC9F3")
    public static let unSelected: Color = Color(hex: "#DADADA")
    
    public static let primeColor1: Color = Color(hex: "#67AEF0")
    public static let primeColor2: Color = Color(hex: "#8FC9F3")
    public static let primeColor3: Color = Color(hex: "#B7E9FE")
    public static let primeColor4: Color = Color(hex: "#D2F7FF")
    public static let primeColor5: Color = Color(hex: "#E1FDFF")
    public static let primeColor6: Color = Color(hex: "#F9FFFD")
    
    public static let gray100: Color = Color(hex: "#454545")
    public static let gray90: Color = Color(hex: "#454B52")
    public static let gray60: Color = Color(hex: "#454545", opacity: 0.6)
    public static let gray50: Color = Color(hex: "#454545", opacity: 0.5)
    public static let gray30: Color = Color(hex: "#454545", opacity: 0.3)
    public static let lightGray01: Color = Color(hex: "#E8E8E8")
    public static let lightGray02: Color = Color(hex: "#EAEDF0")
    public static let lightGray03: Color = Color(hex: "#F8F8F8")
    public static let lightGray04: Color = Color(hex: "#FEFEFE")
    
    public static let dim: Color = Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.6)
}

extension UIColor {
    convenience init(hex: String, opacity: CGFloat? = nil) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hex.hasPrefix("#") {
            _ = hex.removeFirst()
        }
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        if let opacity = opacity {
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: opacity)
        } else {
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    }
    
    public static let backgroundColor: UIColor = UIColor(hex: "#F3F6FB")
    public static let inputBoxColor: UIColor = UIColor(hex: "#DADADA")
    
    //MARK: primeColor
    public static let selected: UIColor = UIColor(hex: "#8FC9F3")
    public static let unSelected: UIColor = UIColor(hex: "#DADADA")
    
    public static let primeColor1: UIColor = UIColor(hex: "#67AEF0")
    public static let primeColor2: UIColor = UIColor(hex: "#8FC9F3")
    public static let primeColor3: UIColor = UIColor(hex: "#B7E9FE")
    public static let primeColor4: UIColor = UIColor(hex: "#D2F7FF")
    public static let primeColor5: UIColor = UIColor(hex: "#E1FDFF")
    public static let primeColor6: UIColor = UIColor(hex: "#F9FFFD")
    
    public static let gray100: UIColor = UIColor(hex: "#454545")
    public static let gray90: UIColor = UIColor(hex: "#454B52")
    public static let gray60: UIColor = UIColor(hex: "#454545", opacity: 0.6)
    public static let gray50: UIColor = UIColor(hex: "#454545", opacity: 0.5)
    public static let gray30: UIColor = UIColor(hex: "#454545", opacity: 0.3)
    public static let lightGray01: UIColor = UIColor(hex: "#E8E8E8")
    public static let lightGray02: UIColor = UIColor(hex: "#EAEDF0")
    public static let lightGray03: UIColor = UIColor(hex: "#F8F8F8")
    
    public static let dim: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.6) //UIColor(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.6)
}

extension Font {
    public static let kr45b: Font = .system(size: 45, weight: .bold, design: .default)
    public static let kr45r: Font = .system(size: 45, weight: .regular, design: .default)
    
    public static let kr40b: Font = .system(size: 40, weight: .bold, design: .default)
    public static let kr40r: Font = .system(size: 40, weight: .regular, design: .default)
    
    public static let kr30b: Font = .system(size: 30, weight: .bold, design: .default)
    public static let kr30r: Font = .system(size: 30, weight: .regular, design: .default)
    
    public static let kr26b: Font = .system(size: 26, weight: .bold, design: .default)
    public static let kr26r: Font = .system(size: 26, weight: .regular, design: .default)
    
    public static let kr20b: Font = .system(size: 20, weight: .bold, design: .default)
    public static let kr20r: Font = .system(size: 20, weight: .regular, design: .default)
    
    public static let kr19b: Font = .system(size: 19, weight: .bold, design: .default)
    public static let kr19r: Font = .system(size: 19, weight: .regular, design: .default)
    
    public static let kr18b: Font = .system(size: 18, weight: .bold, design: .default)
    public static let kr18r: Font = .system(size: 18, weight: .regular, design: .default)
    
    public static let kr16b: Font = .system(size: 16, weight: .bold, design: .default)
    public static let kr16r: Font = .system(size: 16, weight: .regular, design: .default)
    
    public static let kr15b: Font = .system(size: 15, weight: .bold, design: .default)
    public static let kr15r: Font = .system(size: 15, weight: .regular, design: .default)
    
    public static let kr14b: Font = .system(size: 14, weight: .bold, design: .default)
    public static let kr14r: Font = .system(size: 14, weight: .regular, design: .default)
    
    public static let kr13b: Font = .system(size: 13, weight: .bold, design: .default)
    public static let kr13r: Font = .system(size: 13, weight: .regular, design: .default)
    
    public static let kr12b: Font = .system(size: 12, weight: .bold, design: .default)
    public static let kr12r: Font = .system(size: 12, weight: .regular, design: .default)
    
    public static let kr11b: Font = .system(size: 11, weight: .bold, design: .default)
    public static let kr11r: Font = .system(size: 11, weight: .regular, design: .default)
    
    public static let kr10b: Font = .system(size: 10, weight: .bold, design: .default)
    public static let kr10r: Font = .system(size: 10, weight: .regular, design: .default)
    
    public static let kr9r: Font = .system(size: 9, weight: .regular, design: .default)
}

extension UIFont {
    public static let kr30b: UIFont = .systemFont(ofSize: 30, weight: .bold)
    public static let kr30r: UIFont = .systemFont(ofSize: 30, weight: .regular)
    
    public static let kr26b: UIFont = .systemFont(ofSize: 26, weight: .bold)
    public static let kr26r: UIFont = .systemFont(ofSize: 26, weight: .regular)
    
    public static let kr20b: UIFont = .systemFont(ofSize: 20, weight: .bold)
    public static let kr20r: UIFont = .systemFont(ofSize: 20, weight: .regular)
    
    public static let kr19b: UIFont = .systemFont(ofSize: 19, weight: .bold)
    public static let kr19r: UIFont = .systemFont(ofSize: 19, weight: .regular)
    
    public static let kr18b: UIFont = .systemFont(ofSize: 18, weight: .bold)
    public static let kr18r: UIFont = .systemFont(ofSize: 18, weight: .regular)
    
    public static let kr16b: UIFont = .systemFont(ofSize: 16, weight: .bold)
    public static let kr16r: UIFont = .systemFont(ofSize: 16, weight: .regular)
    
    public static let kr15b: UIFont = .systemFont(ofSize: 15, weight: .bold)
    public static let kr15r: UIFont = .systemFont(ofSize: 15, weight: .regular)
    
    public static let kr14b: UIFont = .systemFont(ofSize: 14, weight: .bold)
    public static let kr14r: UIFont = .systemFont(ofSize: 14, weight: .regular)
    
    public static let kr13b: UIFont = .systemFont(ofSize: 13, weight: .bold)
    public static let kr13r: UIFont = .systemFont(ofSize: 13, weight: .regular)
    
    public static let kr12b: UIFont = .systemFont(ofSize: 12, weight: .bold)
    public static let kr12r: UIFont = .systemFont(ofSize: 12, weight: .regular)
    
    public static let kr11b: UIFont = .systemFont(ofSize: 11, weight: .bold)
    public static let kr11r: UIFont = .systemFont(ofSize: 11, weight: .regular)
    
    public static let kr10b: UIFont = .systemFont(ofSize: 10, weight: .bold)
    public static let kr10r: UIFont = .systemFont(ofSize: 10, weight: .regular)
    
    public static let kr9r: UIFont = .systemFont(ofSize: 9, weight: .regular)
}


extension UIImage {
    func resizeImageTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension UIApplication {
    func hideKeyborad() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
