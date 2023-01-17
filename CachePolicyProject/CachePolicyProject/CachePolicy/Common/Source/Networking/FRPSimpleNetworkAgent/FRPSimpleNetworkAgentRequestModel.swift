//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation

//
// FRPSimpleNetworkAgent (Combine version) was inspired on
// https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/ and
// https://medium.com/swlh/better-api-management-in-swift-c2c1ad6354be
// and assync version on
// https://medium.com/geekculture/create-a-generic-networking-layer-using-async-await-9168b6281721 and
// https://www.avanderlee.com/swift/async-await/
//

public extension NetworkinNameSpace {
    struct FRPSimpleNetworkAgentRequestModel {
        public let path: String
        public let httpMethod: Common_HttpMethod
        public let httpBody: [String: Any]?
        public let headerValues: [String: String]?
        public let serverURL: String // baseURLString
        public let responseFormat: Common_NetworkClientResponseFormat

        public init(path: String,
                    httpMethod: Common_HttpMethod,
                    httpBody: [String: String]?,
                    headerValues: [String: String]?,
                    serverURL: String,
                    responseType: Common_NetworkClientResponseFormat) {
            self.path = path
            self.httpMethod = httpMethod
            self.httpBody = httpBody
            self.headerValues = headerValues
            self.serverURL = serverURL
            self.responseFormat = responseType
        }
    }
}

public extension Common_FRPNetworkAgentRequestModel {
    var urlRequest: URLRequest? {
        let serverURLEscaped = serverURL.dropLastIf("/")
        var pathEscaped = path.dropFirstIf("/")
        if let escaped = pathEscaped.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), pathEscaped != escaped {
            pathEscaped = escaped
        }
        let urlString: String = pathEscaped.isEmpty ? serverURLEscaped : serverURLEscaped + "/" + pathEscaped

        return URLRequest.with(urlString: urlString.trim,
                               httpMethod: httpMethod.rawValue,
                               httpBody: httpBody,
                               headerValues: headerValues)
    }
}
