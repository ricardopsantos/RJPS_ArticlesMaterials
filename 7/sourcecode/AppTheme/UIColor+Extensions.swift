//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

//swiftlint:disable rule_UIColor_2 rule_UIColor_3

import UIKit
import Foundation
//
import RJSLibUFAppThemes

public extension UIColor {

    struct App {
        private init() {}

        public struct TopBar {
            private init() {}
            public static var background: UIColor { return ColorName.primary.color }
            public static var titleColor: UIColor { return ColorName.onPrimary.color }
        }

        public struct UIButton {
            public static var backgroundColorInnGage: UIColor { return UIColor.Pack1.grey_6.color }
            public static var textColorInnGage: UIColor { return UIColor.Pack1.grey_1.color }
            public static var backgroundColorDefault: UIColor { return  ColorName.primary.color }
            public static var textColorDefault: UIColor { return  ColorName.onPrimary.color }
        }

        public struct UILabel {
            public static var lblBackgroundColor: UIColor { return UIColor.Pack1.grey_6.color }
            public static var lblTextColor: UIColor { return UIColor.Pack1.grey_1.color }
        }

        public static var background: UIColor { return ColorName.onPrimary.color }
        public static var onBackground: UIColor { return ColorName.primary.color }

        public static var primary: UIColor { return ColorName.primary.color }
        public static var onPrimary: UIColor { return ColorName.onPrimary.color }

        public static var error: UIColor { return ColorName.danger.color }
        public static var success: UIColor { return ColorName.success.color }
        public static var warning: UIColor { return ColorName.warning.color }

        public static var accept: UIColor { return ColorName.success.color }
        public static var reject: UIColor { return ColorName.warning.color }
        public static var remind: UIColor { return ColorName.danger.color }

    }
}
