//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit

public protocol HotCacheRepositoryProtocol {
    func add(object: AnyObject, withKey: String)
    func get(key: String) -> AnyObject?
    func clean(sender: String)
}
