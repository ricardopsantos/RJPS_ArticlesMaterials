//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFBase
//
import DevTools
import BaseDomain

public extension DevTools.Log {
    static func appCode(_ appCode: AppCodes, function: String = #function, file: String = #file, line: Int = #line) {
        guard enabled else { return }
        // RJSLib.Logger is a simple logger that handles verbose, warning and errors
        RJSLib.Logger.message(appCode.localisedMessageForDevTeam, function: function, file: file, line: line)
    }
}
