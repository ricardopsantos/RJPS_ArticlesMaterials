//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
//
import DevTools
import BaseDomain

extension AppDelegate {
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        DevTools.Log.message("App is handling URL : \(url)")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        DevTools.Log.message("App is handling url [\(url)] with option [\(options)]")
        return true
    }

    // MARK: Notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DevTools.Log.message("App did register for push notifications with token [\(deviceToken)]")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        guard DevTools.onRealDevice else { return }
        DevTools.Log.error("App did fail register for push notifications with error [\(error)]")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }

    // MARK: Shortcuts
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        DevTools.Log.message("App shortcutItem [\(shortcutItem)]")
    }

    // MARK: Universal Links
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                DevTools.Log.message("Universal [\(url)]")
            }
        }
        return true
    }
    
}
