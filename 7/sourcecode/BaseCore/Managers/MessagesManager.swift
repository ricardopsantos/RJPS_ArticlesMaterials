//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import ToastSwiftFramework
import DevTools
import RJSLibUFAppThemes
//
import BaseConstants
import AppTheme
import BaseDomain

//
// READ
//
// Simple way to display messages for the user (using ToastSwiftFramework)
// The messages have 3 types (success, warning, error) depending on the severity
// Dependency resolved @ `DIRootAssemblyResolver.messagesManager.xxx`
//

public class MessagesManager: MessagesManagerProtocol {
    public func displayMessage(_ message: String, type: AlertType) {
        var style = ToastStyle()
        style.cornerRadius = 5
        style.displayShadow = true
        style.messageFont = AppFonts.Styles.paragraphSmall.rawValue
        switch type {
        case .success: style.backgroundColor = ComponentColor.success.withAlphaComponent(FadeType.superLight.rawValue)
        case .warning: style.backgroundColor = ComponentColor.warning.withAlphaComponent(FadeType.superLight.rawValue)
        case .error: style.backgroundColor = ComponentColor.error.withAlphaComponent(FadeType.superLight.rawValue)
        }
        style.messageColor = .white
        DevTools.topViewController()?.view.makeToast(message, duration: 5, position: .top, style: style)
    }
}
