//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
//
import RJSLibUFBase

public struct AppConstants {
    private init() {}

    public static var propertiesList: NSDictionary? {
        var nsDictionary: NSDictionary?
        let fileName = "AppConstants.PropertiesList" // Must be on the app [GoodToGo] Target
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        return nsDictionary
    }

    public static let defaultAnimationsTime = RJS_Constants.defaultAnimationsTime

    public struct Misc {
        public static let sampleEmail = "joe@joe.com"
        public static let samplePassword = "12345"
    }

    public struct Rx {
        // https://medium.com/fantageek/throttle-vs-debounce-in-rxswift-86f8b303d5d4
        // Throttle : Will ignore events between the time span of xxxx milliseconds
        // Debounce : Only "fire" event, after the last happen after xxxx milliseconds.... Good to avoid double taps
        //static let tappingDefaultThrottle    = 10
        public static let tappingDefaultDebounce    = 500

        public static let servicesDefaultThrottle   = 10
        public static let servicesDefaultDebounce   = 250
        
        public static let textFieldsDefaultDebounce = 1000
    }

    public struct Cache {
        public static let serverRequestCacheLifeSpam: Int = 5 // minutes
        public static let servicesCache: String = "servicesCache"
    }
    
    public struct Dev {
        private init() {}
        public static let tapDefaultDisableTime: Double = 2
        public static let cellIdentifier      = "DefaultCell"
        public static let keyCoreDataLastUser = "keyCoreDataLastUser"

        public static let keyCoreDataSaveLang = "keyCoreDataSaveLang"
        public static let numberOfLogins      = "numberOfLogins"
    }

    public static var buttonDefaultSize: CGSize { return CGSize(width: 125, height: 44) }

}
