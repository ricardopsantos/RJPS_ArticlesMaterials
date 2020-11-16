//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import BaseDomain

// swiftlint:disable redundant_string_enum_value

public extension GalleryAppResponseDto {
    struct ImageInfo: ResponseDtoProtocol {
        public let sizes: Sizes
        public let stat: String

        public init() {
            self.sizes = Sizes()
            self.stat = ""
        }
        public struct Sizes: ResponseDtoProtocol {
            let canblog, canprint, candownload: Int
            let size: [Size]

            public init() {
                self.canblog = 0
                self.canprint = 0
                self.candownload = 0
                self.size = []
            }
        }

        public struct Size: ResponseDtoProtocol {
            let label: String
            let width, height: Int
            let source, url: String
            let media: Media

            public init() {
                self.label = ""
                self.width = 0
                self.height = 0
                self.source = ""
                self.url = ""
                self.media = .photo
            }
        }

        public enum Media: String, ResponseDtoProtocol {
            case photo = "photo"
        }
    }
}
