//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import AppResources
import BaseConstants
import DevTools
import PointFreeFunctions
import Extensions

public extension UIButton {

    // Cant be o Designables because the Designables allready import AppTheme
    static var defaultFont: UIFont { AppFonts.Styles.paragraphMedium.rawValue }

    var layoutStyle: UIButton.LayoutStyle {
        set { apply(style: newValue) }
        get { return .notApplied }
    }
    
    func setState(enabled: Bool) {
        self.isUserInteractionEnabled = enabled
        self.alpha = enabled ? 1.0 : FadeType.disabledUIElementDefaultValue.rawValue
    }

    func apply(style: UIButton.LayoutStyle) {
        switch style {
        case .notApplied  : _ = 1
        case .primary     : self.applyStylePrimary()
        case .secondary   : self.applyStyleSecondary()
        case .secondaryDestructive : self.applyStyleSecondaryDestructive()
        case .inngage     : self.applyStyleInngage()
        case .accept      : self.applyStyleAccept()
        case .reject      : self.applyStyleReject()
        case .remind      : self.applyStyleRemind()
        }
    }
}

private extension UIButton {

    func applySharedProperties() {
        setState(enabled: true)
        addShadow(shadowType: .regular)
    }

    func applyStyleInngage() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = ComponentColor.UIButton.backgroundColorInnGage
        self.setTextColorForAllStates(ComponentColor.UIButton.textColorInnGage)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds      = true
    }

    func applyStyleAccept() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = ComponentColor.accept
        self.setTextColorForAllStates(ComponentColor.UIButton.textColorDefault)
        self.layer.cornerRadius = AppConstants.buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleReject() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = ComponentColor.reject
        self.setTextColorForAllStates(ComponentColor.UIButton.textColorDefault)
        self.layer.cornerRadius = AppConstants.buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleRemind() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = ComponentColor.remind
        self.setTextColorForAllStates(ComponentColor.UIButton.textColorDefault)
        self.layer.cornerRadius = AppConstants.buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }
    func applyStylePrimary() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = ComponentColor.UIButton.backgroundColorDefault
        self.setTextColorForAllStates(ComponentColor.UIButton.textColorDefault)
        self.layer.cornerRadius = AppConstants.buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleSecondary() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = UIColor.white
        self.setTextColorForAllStates(ComponentColor.primary)
        self.layer.borderWidth  = 2
        self.layer.borderColor  = ComponentColor.primary.cgColor
        self.layer.cornerRadius = AppConstants.buttonDefaultSize.height / 2
        self.clipsToBounds      = true
    }

    func applyStyleSecondaryDestructive() {
        applySharedProperties()
        self.titleLabel?.font = UIButton.defaultFont
        self.backgroundColor  = UIColor.white
        self.setTextColorForAllStates(ComponentColor.error)
        self.layer.cornerRadius = AppConstants.buttonDefaultSize.height / 2
        self.clipsToBounds      = true
        self.layer.borderWidth  = 2
        self.layer.borderColor  = ComponentColor.error.cgColor
    }

}
