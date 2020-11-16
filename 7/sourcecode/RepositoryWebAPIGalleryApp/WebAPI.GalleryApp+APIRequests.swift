//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
//
import RJSLibUFNetworking
//
import BaseConstants
import DevTools
import BaseRepositoryWebAPI
import DomainGalleryApp

// MARK: - Target

public extension WebAPI.GalleryAppAPIRequest {
    enum Target {
        case search
        case imageInfo

        public var baseURL: String {
            return "https://api.flickr.com/services/rest"
        }

        private var key: String { key2 }
        private var key1: String { "DTBfK2jeRNQ3ABo9l+elSOK9hYeMkKhoTt6f9L43aU7iq+Y7rId+k4TSJDIVNZy6LNaL2uHVkyVy2CEC".aesDecrypt() }
        private var key2: String { "D3M89jxFfjqVlom5bytkK44D2rPcV54IaPQE585fEutokj3B49I6QalJjzEateBxPrF4/JWyXsTQYhRd".aesDecrypt() }

        public var endpoint: String {
            switch self {
            case .search: return "\(baseURL)/?method=flickr.photos.search&api_key=\(key)&format=json&nojsoncallback=1"
            case .imageInfo: return "\(baseURL)/?method=flickr.photos.getSizes&api_key=\(key)&format=json&nojsoncallback=1"
            }
        }

        public var httpMethod: String {
            switch self {
            case .search: return RJS_SimpleNetworkClient.HttpMethod.get.rawValue
            case .imageInfo: return RJS_SimpleNetworkClient.HttpMethod.get.rawValue
            }
        }
    }
}

// MARK: - Search

public extension WebAPI.GalleryAppAPIRequest {

    struct Search: WebAPIRequestProtocol {
        public var returnOnMainTread: Bool
        public var debugRequest: Bool = DevTools.FeatureFlag.debugRequests.isTrue
        public var urlRequest: URLRequest
        public var responseType: RJS_SimpleNetworkClientResponseType
        public var mockedData: String? { return WebAPI.useMock ? AppConstants.Mocks.GalleryApp.search_200 : nil }

        init(request: GalleryAppRequests.Search) throws {
            let urlString = Target.search.endpoint + request.urlEscaped
            guard let url = URL(string: urlString) else {
                throw APIErrors.invalidURL(url: urlString)
            }
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = Target.search.httpMethod
            responseType      = .json
            returnOnMainTread = true
        }
    }

}

// MARK: - ImageInfo

public extension WebAPI.GalleryAppAPIRequest {

    struct ImageInfo: WebAPIRequestProtocol {
        public var returnOnMainTread: Bool
        public var debugRequest: Bool = DevTools.FeatureFlag.debugRequests.isTrue
        public var urlRequest: URLRequest
        public var responseType: RJS_SimpleNetworkClientResponseType
        public var mockedData: String? { return WebAPI.useMock ? AppConstants.Mocks.GalleryApp.imageInfo_200 : nil }

        init(request: GalleryAppRequests.ImageInfo) throws {
            let urlString = Target.imageInfo.endpoint + request.urlEscaped
            guard let url = URL(string: urlString) else {
                throw APIErrors.invalidURL(url: urlString)
            }
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = Target.search.httpMethod
            responseType      = .json
            returnOnMainTread = true
        }
    }
}
