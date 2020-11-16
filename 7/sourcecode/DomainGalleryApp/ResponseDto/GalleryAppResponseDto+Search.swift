//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import BaseDomain

public extension GalleryAppResponseDto {
    struct Search: ResponseDtoProtocol {
        public let photos: Photos
        public let stat: String

        public struct Photos: ResponseDtoProtocol {
            public let page, pages, perpage: Int
            public let total: String
            public let photo: [Photo]
        }

        public struct Photo: ResponseDtoProtocol {
            public let id, owner, secret, server: String
            public let farm: Int
            public let title: String
            public let ispublic, isfriend, isfamily: Int
        }
    }
}
