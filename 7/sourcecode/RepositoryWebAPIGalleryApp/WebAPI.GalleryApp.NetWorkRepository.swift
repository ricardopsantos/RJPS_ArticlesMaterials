//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RJSLibUFNetworking
//
import DevTools
import BaseConstants
import DomainGalleryApp

/**
* WE CANT HAVE BUSINESS RULES HERE! THE CLIENT JUST DO THE OPERATION AND LEAVE
*/

public extension WebAPI.GalleryApp {

    class NetWorkRepository: GalleryAppNetWorkRepositoryProtocol {
        public init() { }

        public func imageInfo(_ request: GalleryAppRequests.ImageInfo, completionHandler: @escaping GalleryAppResponseImageInfoCompletionHandler) {
            do {
                let apiRequest: WebAPIRequestProtocol = try WebAPI.GalleryAppAPIRequest.ImageInfo(request: request)
                let apiClient: RJS_SimpleNetworkClientProtocol = RJS_SimpleNetworkClient()
                apiClient.execute(request: apiRequest, completionHandler: { (result: Result<RJS_SimpleNetworkClientResponse<GalleryAppResponseDto.ImageInfo>>) in
                    completionHandler(result)
                })
             } catch let error {
                completionHandler(Result.failure(error))
             }
        }

        public func search(_ request: GalleryAppRequests.Search, completionHandler: @escaping GalleryAppResponseSearchCompletionHandler) {
            do {
                let apiRequest: WebAPIRequestProtocol = try WebAPI.GalleryAppAPIRequest.Search(request: request)
                let apiClient: RJS_SimpleNetworkClientProtocol = RJS_SimpleNetworkClient()
                apiClient.execute(request: apiRequest) { (result: Result<RJS_SimpleNetworkClientResponse<GalleryAppResponseDto.Search>>) in
                    completionHandler(result)
                }
             } catch let error {
                 completionHandler(Result.failure(error))
             }
        }
    }
}
