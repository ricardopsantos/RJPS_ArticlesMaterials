//
//  Created by Ricardo Santos on 22/02/2021.
//

import Foundation

public enum CachePolicy: String, CaseIterable {
    case ignoringCache // Cache ignored, and returns latest available value
    case cacheElseLoad // Will use cache if available, else returns latest available value (good because avoids server calls)
    case cacheAndLoad  // Can emit twice, one for cache (if available) and other with the latest available value
    case cacheDontLoad // Use cache only
    
    public var canUseCache: Bool {
        return self != .ignoringCache
    }
}
