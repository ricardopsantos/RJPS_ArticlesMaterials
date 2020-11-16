//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import PointFreeFunctions
import BaseCore
//
import DomainGalleryApp

public extension Mappers {
    struct GalleryApp {
        private init() {}
    }
}

public extension GalleryAppResponseDto.Search {
    var toDomain: GalleryAppModel.Search? {
        return perfectMapper(inValue: self, outValue: GalleryAppModel.Search.self)
    }
}

public extension GalleryAppResponseDto.ImageInfo {
    var toDomain: GalleryAppModel.ImageInfo? {
        return perfectMapper(inValue: self, outValue: GalleryAppModel.ImageInfo.self)
    }
}
