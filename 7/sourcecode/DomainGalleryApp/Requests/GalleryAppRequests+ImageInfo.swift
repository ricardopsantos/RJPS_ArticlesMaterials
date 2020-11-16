//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

// Encapsulate API Requests
public extension GalleryAppRequests {
    struct ImageInfo {
        let photoId: String

        public init(photoId: String) {
            self.photoId = photoId
        }

        // Improve this
        public var urlEscaped: String {
            let result = "&photo_id=\(photoId)"
            return result.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
    }
}
