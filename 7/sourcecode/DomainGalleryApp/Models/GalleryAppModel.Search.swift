//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import BaseDomain

public extension GalleryAppModel {
    struct Search: ModelEntityProtocol {
        public let photos: Photos
        public let stat: String

        public struct Photos: ModelEntityProtocol {
            public let page, pages, perpage: Int
            public let total: String
            public let photo: [Photo]
        }

        public struct Photo: ModelEntityProtocol {
            public let id, owner, secret, server: String
            public let farm: Int
            public let title: String
            public let ispublic, isfriend, isfamily: Int
        }
    }
}
