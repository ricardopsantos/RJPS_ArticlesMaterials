//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import BaseDomain

// swiftlint:disable redundant_string_enum_value

public extension GalleryAppModel {
    struct ImageInfo: ModelEntityProtocol {
        public let sizes: Sizes
        public let stat: String

        public struct Sizes: ModelEntityProtocol {
            public let canblog, canprint, candownload: Int
            public let size: [Size]
        }

        public struct Size: ModelEntityProtocol {
            public let label: String
            public let width, height: Int
            public let source, url: String
            public let media: Media
        }

        public enum Media: String, ModelEntityProtocol {
            case photo = "photo"
        }
    }
}
