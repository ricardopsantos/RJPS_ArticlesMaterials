//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RJSLibUFAppThemes
//
import BaseConstants

public extension UILabel {
    
    var layoutStyle: UILabel.LayoutStyle {
        set { apply(style: newValue) }
        get { return .notApplied }
    }

    func apply(style: UILabel.LayoutStyle) {
        let navigationBarTitle = {
            self.textColor       = ComponentColor.TopBar.titleColor
            self.font            = AppFonts.Styles.headingMedium.rawValue
        }
        let title = {
            self.textColor       = ComponentColor.UILabel.lblTextColor
            self.font            = AppFonts.Styles.paragraphBold.rawValue
        }
        let value = {
            self.textColor       = ComponentColor.UILabel.lblTextColor.withAlphaComponent(FadeType.superLight.rawValue)
            self.font            = AppFonts.Styles.paragraphSmall.rawValue
        }
        let text = {
            self.textColor       = ComponentColor.UILabel.lblTextColor
            self.font            = AppFonts.Styles.caption.rawValue
        }
        let error = {
            self.textColor       = ComponentColor.error
            self.font            = AppFonts.Styles.captionSmall.rawValue
        }

        let info = {
            self.backgroundColor = ComponentColor.primary.withAlphaComponent(FadeType.regular.rawValue)
            self.textColor       = ComponentColor.onPrimary
            self.font            = AppFonts.Styles.captionLarge.rawValue
            #warning("fix! brook on xcodegen conversion")
           // self.addShadow()
           // self.addCorner(radius: 5)
        }
        switch style {
        case .notApplied         : _ = 1
        case .navigationBarTitle : navigationBarTitle()
        case .title              : title()
        case .value              : value()
        case .text               : text()
        case .error              : error()
        case .info               : info()
        }
    }
}
