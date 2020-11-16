//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

public struct CacheUtils {

    // Given some key (String), and an array of Strings (typically) some function params, will return a
    // composed key with all of that. That key will then be used as "master" key while storing something
    
    public static func composedKey(_ key: String, _ keyParams: [String]) -> String {
        if keyParams.count > 0 {
            return "\(key)_\(parseKeyParams(keyParams))"
        } else {
            return "\(key)"
        }
    }

    public static func parseKeyParams(_ params: [String]) -> String {
        return "[" + params.joined(separator: ",") + "]"
    }
}
