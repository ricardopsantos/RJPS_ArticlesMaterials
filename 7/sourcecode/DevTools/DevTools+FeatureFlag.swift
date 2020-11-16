//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFStorage

public extension DevTools {
    enum FeatureFlag: String, CaseIterable {

        case showToastsOnErrors        = "Show toast if error happens"
        case devTeam_useMockedData     = "Use Mock Data"
        case showDebugStatsViewOnView  = "Show Stats View"
        case appLogsEnabled            = "Logs: enabled"
        case logDeInitEvent            = "Logs: log deinit event"
        case nsLogger                  = "If [true] log to console, else to NSLogger"
        case debugRequests             = "If [true] log API requests"

        case showScene_carTrack    = "Scene Enabled: Exam.CarTrack"
        case showScene_gallery     = "Scene Enabled: Exam.Gallery "

        case showScene_vipTemplate = "Scene Enabled: VIP Template"

        // Default value
        public var defaultValue: Bool {
            switch self {
            case .showToastsOnErrors:       return DevTools.devModeIsEnabled
            case .appLogsEnabled:           return DevTools.devModeIsEnabled
            case .showDebugStatsViewOnView: return DevTools.devModeIsEnabled
            case .devTeam_useMockedData:    return false
            case .logDeInitEvent:           return false
            case .nsLogger:                 return false
            case .debugRequests:            return false

            case .showScene_vipTemplate: return true

            case .showScene_carTrack:    return true
            case .showScene_gallery:     return true
            }
        }

        // If FF is visible is visible on DebugScreen to be changed
        public var isVisible: Bool {
             switch self {
             case .showToastsOnErrors:       return true
             case .devTeam_useMockedData:    return true
             case .appLogsEnabled:           return true
             case .nsLogger:                 return true
             case .logDeInitEvent:           return true
             case .showDebugStatsViewOnView: return true
             case .debugRequests:            return true

             case .showScene_carTrack:       return true
             case .showScene_vipTemplate:    return true
             case .showScene_gallery:        return true
            }
        }

        public var isTrue: Bool {
            return FeatureFlag.getFlag(self)
        }

        public static func getFlag(_ flagName: FeatureFlag) -> Bool {
            let defaultValue = flagName.defaultValue
            guard !DevTools.isProductionReleaseApp else {
                // If production then we need to get the default value
                return defaultValue
            }

            if RJS_UserDefaults.existsWith(key: flagName.rawValue) {
                if let value = RJS_UserDefaults.getWith(key: flagName.rawValue) {
                    return "\(value)" == "\(true)"
                }
            }
            return defaultValue

        }

        public static func setFlag(_ flagName: FeatureFlag, value: Bool) {
            RJS_UserDefaults.save("\(value)" as AnyObject, key: flagName.rawValue)
        }
    }
}
