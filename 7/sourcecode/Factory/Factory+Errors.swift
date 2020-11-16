//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import BaseDomain
import AppResources

public extension Factory {
    struct Errors {
        private init() {}
        public static func with(appCode: AppCodes, info: String="") -> Error {
            let domain: String = "\(Bundle.main.bundleIdentifier!)"
            let code: Int = appCode.rawValue
            var userInfo: [String: Any] = [:]
            userInfo["userInfo.appCode"]        = "\(appCode.rawValue)"
            userInfo["userInfo.dev.localised"]  = appCode.localisedMessageForDevTeam
            userInfo["userInfo.prod.localised"] = appCode.localisedMessageForView
            userInfo["extra.prod.info"]         = appCode.localisedMessageForView
            return NSError(domain: domain, code: code, userInfo: userInfo)
        }
    }
}

// NSError to AppCode!

public extension NSError {
    var appCode: AppCodes? {
        if let appCodeString = self.userInfo["userInfo.appCode"] {
            if let appCode = AppCodes(rawValue: Int("\(appCodeString)") ?? -1) {
                return appCode
            }
        }
        return AppCodes.unknownError
    }
}

// Error to AppCode!

public extension Error {

    var localisedMessageForView: String {
        if let appCode = self.appCode {
            return appCode.localisedMessageForView
        }
        return Messages.defaultErrorMessage
    }

    var appCode: AppCodes? {
        if let nsError = self as? NSError { return nsError.appCode }
        return AppCodes.unknownError
    }
}

public extension AppCodes {

    static func initWith(error: Error) -> AppCodes {
        return AppCodes.unknownError
    }

    func makeErrorWith(code: AppCodes) -> Error {
        return code.toError
    }

    var toError: Error {
        return Factory.Errors.with(appCode: self)
    }
}
