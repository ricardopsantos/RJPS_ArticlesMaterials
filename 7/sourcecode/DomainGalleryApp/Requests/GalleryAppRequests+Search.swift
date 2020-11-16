//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

// Encapsulate API Requests
public extension GalleryAppRequests {
    struct Search {
        public let tags: [String]
        public let page: Int

        public init(tags: [String], page: Int=1) {
            self.tags = tags
            self.page = page
        }

        // Improve this
        public var urlEscaped: String {
            var result = "&page=\(page)"
            if tags.count > 0 {
                result = "\(result)&tags=" + tags.joined(separator: ",")
            }
            return result.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
    }
}
