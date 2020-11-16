//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
//
import RxSwift
import RxCocoa
import RJSLibUFBase
import NSLoggerSwift
//import Firebase
//
import BaseConstants
import PointFreeFunctions
import DevTools

extension AppDelegate {
    func setup(application: UIApplication) {
        DevTools.Log.enabled = DevTools.FeatureFlag.appLogsEnabled.isTrue
        AppEnvironments.setup()
  //      FirebaseApp.configure()
        DevTools.Log.message("RJPSLib Version : \(RJSLib.version)\nNumber of logins : \(AppUserDefaultsVars.incrementIntWithKey(AppConstants.Dev.numberOfLogins))")
    }
}
