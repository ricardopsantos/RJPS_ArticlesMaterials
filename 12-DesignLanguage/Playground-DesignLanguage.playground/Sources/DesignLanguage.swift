import Foundation
import UIKit

public extension UIColor {

    enum Pack3: CaseIterable {
        public typealias RawValue = UIColor
        public init?(rawValue: RawValue) { return nil }
        public var color: UIColor { return self.rawValue }
        case background
        case onBackground
        case surface
        case onSurface
        case detail
        case onDetail
        case divider
        case overlayBackground
        case void
        case onVoid
        case primary
        case onPrimary
        case primaryVariant
        case onPrimaryVariant
        case secondary
        case onSecondary
        case success
        case onSuccess
        case danger
        case onDanger
        case warning
        case onWarning

        public var name: String { return "\(self)" }
                
        public var rawValue: RawValue {
            switch self {
            case .background: return UIColor(white: 250.0 / 255.0, alpha: 1.0)
            case .onBackground: return  UIColor(red: 9.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
            case .surface: return UIColor.white
            case .onSurface: return UIColor(red: 9.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
            case .detail: return UIColor(red: 187.0 / 255.0, green: 195.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0)
            case .onDetail: return UIColor.white
            case .divider: return UIColor.lightGray
            case .overlayBackground: return UIColor(white: 250.0 / 255.0, alpha: 1.0).withAlphaComponent(0.5)
            case .void: return UIColor.black
            case .onVoid: return UIColor.white
            case .primary: return  UIColor(red: 113.0 / 255.0, green: 185.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
            case .onPrimary: return UIColor.white
            case .primaryVariant: return UIColor(red: 113.0 / 255.0, green: 185.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0).withAlphaComponent(0.1)
            case .onPrimaryVariant: return UIColor(red: 113.0 / 255.0, green: 185.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
            case .secondary: return UIColor.yellow
            case .onSecondary: return UIColor(red: 9.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
            case .success: return UIColor.green
            case .onSuccess: return UIColor.white
            case .danger: return UIColor.red
            case .onDanger: return UIColor.white
            case .warning: return UIColor.orange
            case .onWarning: return UIColor.white
            }
        }
    }
}

public extension UIFont {
    struct MyFonts {

        static var bold: String = "HelveticaNeue-Medium"
        static var regular: String = "HelveticaNeue"
        static var light: String = "HelveticaNeue-Thin"
        
        public enum Styles: CaseIterable {
            public typealias RawValue = UIFont

            case headingJumbo
            case headingBold
            case headingMedium
            case headingSmall
            case paragraphBold
            case paragraphMedium
            case paragraphSmall
            case captionLarge
            case caption
            case captionSmall

            public init?(rawValue: RawValue) { return nil }

            public var rawValue: RawValue {
                switch self {
                case .headingJumbo: return UIFont(name: MyFonts.light, size: 38.0)!
                case .headingBold: return UIFont(name: MyFonts.bold, size: 28.0)!
                case .headingMedium:  return UIFont(name:  MyFonts.regular, size: 28.0)!
                case .headingSmall: return UIFont(name: MyFonts.light, size: 24.0)!
                case .paragraphBold:  return UIFont(name:  MyFonts.regular, size: 18.0)!
                case .paragraphMedium: return UIFont(name:  MyFonts.regular, size: 16.0)!
                case .paragraphSmall: return UIFont(name: MyFonts.light, size: 16.0)!
                case .captionLarge: return UIFont(name: MyFonts.light, size: 14.0)!
                case .caption: return UIFont(name:  MyFonts.regular, size: 12.0)!
                case .captionSmall: return UIFont(name:  MyFonts.regular, size: 10.0)!
                }
            }
        }
    }
}


public enum LabelStyle {
    case title
    case subTitle
    case text
    case notApplied
}

public extension UILabel {
    
    var layoutStyle: LabelStyle {
        set { apply(style: newValue) }
        get { return .notApplied }
    }

    func apply(style: LabelStyle) {

        let title = {
            self.textColor = UIColor.Pack3.primary.color
            self.font = UIFont.MyFonts.Styles.headingBold.rawValue
        }
        let subTitle = {
            self.textColor = UIColor.Pack3.void.color
            self.font = UIFont.MyFonts.Styles.paragraphMedium.rawValue
        }
        let text = {
            self.textColor = UIColor.Pack3.onSecondary.color
            self.font = UIFont.MyFonts.Styles.caption.rawValue
        }

        switch style {
        case .notApplied  : _ = 1
        case .title       : title()
        case .subTitle    : subTitle()
        case .text        : text()
        }
    }
}


public struct UIKitFactory {
    private init() { }
    
    public static func labelWith(text: String,
                      style: LabelStyle,
                      textAlignment: NSTextAlignment = .justified) -> UILabel {
        let some = UILabel()
        some.layoutStyle = style
        some.text = text
        some.textAlignment = textAlignment
        return some
    }
}
