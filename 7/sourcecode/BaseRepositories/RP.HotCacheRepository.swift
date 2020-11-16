//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFStorage
//
import UIKit
import AVFoundation
import BaseDomain

//
// READ
//
// Dependency resolved @ `DIRootAssemblyResolver.hotCacheRepository.xxx`
//
// This class make usage on RJSLib.Storages.CacheLive, implemented on RJPSLib_Storage, and that
// contains storage utils (add, get, clean) using NSCache (lost on device restart)
//

public extension RP {
    class HotCacheRepository: HotCacheRepositoryProtocol {
        public init () {}

        private var cacheHandler = RJS_LiveCache.shared

        public func add(object: AnyObject, withKey: String) {
            cacheHandler.add(object: object, withKey: withKey)
        }
        public func get(key: String) -> AnyObject? {
            return cacheHandler.get(key: key)
        }
        public func clean(sender: String) {
            cacheHandler.clean()
        }
    }
}
