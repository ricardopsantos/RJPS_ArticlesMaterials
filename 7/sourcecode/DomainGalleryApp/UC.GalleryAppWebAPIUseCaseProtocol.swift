//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFNetworking
import RxSwift
//
import BaseDomain

/**
Use case Protocol for things related with the Web API. (Its not the API Protocol)
 */

public protocol GalleryAppWebAPIUseCaseProtocol: class {

    func search(_ request: GalleryAppRequests.Search, cacheStrategy: CacheStrategy) -> Observable<GalleryAppResponseDto.Search>

    func imageInfo(_ request: GalleryAppRequests.ImageInfo, cacheStrategy: CacheStrategy) -> Observable<GalleryAppResponseDto.ImageInfo>

}
