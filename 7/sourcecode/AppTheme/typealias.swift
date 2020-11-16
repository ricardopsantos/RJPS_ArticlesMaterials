//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

//swiftlint:disable rule_UIColor_1 rule_UIFont_1

import UIKit
import Foundation
//
import RJSLibUFAppThemes
//
import Extensions

public struct AppTheme {
    private init() {}
}

// Pack of 22 color namings, inspired on https://developer.android.com/reference/kotlin/androidx/compose/material/Colors
// Its a way of having a colors on the app, but where the color value its not the color it self, but instead is the place
// where that color is being used
// Have things like : surface, onSurface, detail, onDetail, success, onSuccess, ...
public typealias ColorName = RJS_ColorName

// ComponentColor encapsulate a way to relate a UIComponents or Actions ALLWAYS with the same `ColorName`
// Have things like ComponentColor.TopBar.background or ComponentColor.TopBar.titleColor that related with UI elements
// but have things like ComponentColor.accept, ComponentColor.remind, that are related with types of actions
public typealias ComponentColor = UIColor.App

// Fonts Shortcut: https://github.com/ricardopsantos/RJPSLib/blob/master/RJSPLib.AppThemes/LibCode/UIFont%2BExtensions.swift
// Font styles utils with a font builder for Bold, Regular and Light, and also pre-built styles like : headingJumbo, headingBold, headingMedium, headingSmall
public typealias AppFonts = RJS_Fonts
