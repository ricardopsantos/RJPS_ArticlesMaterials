//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import BaseConstants
import BaseDomain
import DevTools

struct AppEnvironments {

    enum AppMode: Int {
        case prod
        case qa
        case dev
        case mock
    }

    static var current: AppMode = .dev

    static var isDev: Bool { return current == .dev }
    static var isQA: Bool { return current == .qa }
    static var isProd: Bool { return current == .prod }
    static var isMock: Bool { return current == .mock }

    static func setup() {

        var appMode: String? {
            return (Bundle.main.infoDictionary?["BuildConfig_AppMode"] as? String)?.replacingOccurrences(of: "\\", with: "")
        }

        let block_recover = {
            DevTools.Log.appCode(.notPredicted)
            current = .dev
        }

        if let mode = appMode {
            switch mode {
            case "Debug.Dev"  : current = .dev
            case "Debug.QA"   : current = .qa
            case "Debug.Prod" : current = .prod
            case "Release"    : current = .prod
            case "Mock"       : current = .mock
            default           :
                block_recover()
            }
        } else {
            block_recover()
        }
    }
}
