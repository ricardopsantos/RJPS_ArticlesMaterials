//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RxSwift
import RxCocoa
//
import BaseUI
import AppTheme
import Extensions
import DevTools
import PointFreeFunctions
import UIGalleryApp

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public var reachabilityService: ReachabilityService? = DevTools.reachabilityService

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setup(application: application)
        self.window?.rootViewController = UIGalleryAppEntryPoint.instance()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // handle any deep-link
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
}
