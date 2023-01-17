//
//  Created by Ricardo Santos on 14/02/2021.
//

import Foundation
import Combine

//
// FRPSimpleNetworkAgent (Combine version) was inspired on
// https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/ and
// https://medium.com/swlh/better-api-management-in-swift-c2c1ad6354be
// and assync version on
// https://medium.com/geekculture/create-a-generic-networking-layer-using-async-await-9168b6281721 and
// https://www.avanderlee.com/swift/async-await/
//

public protocol FRPSimpleNetworkAgentProtocol {
    var client: Common_FRPSimpleNetworkAgent { get set }
    
    func runV1<T: Decodable>(request: URLRequest,
                             decoder: JSONDecoder,
                             dumpResponse: Bool,
                             logError: Bool,
                             responseType: Common_NetworkClientResponseFormat) -> AnyPublisher<T, Common_FRPNetworkAgentAPIError>
    
    @available(iOS 15.0.0, *)
    func runV2<T: Decodable>(request: URLRequest,
                             decoder: JSONDecoder,
                             dumpResponse: Bool,
                             logError: Bool,
                             responseType: Common_NetworkClientResponseFormat) async throws -> T
}

public extension FRPSimpleNetworkAgentProtocol {
    func runV1<T: Decodable>(request: URLRequest,
                             decoder: JSONDecoder = JSONDecoder(),
                             dumpResponse: Bool,
                             logError: Bool,
                             responseType: Common_NetworkClientResponseFormat) -> AnyPublisher<T, Common_FRPNetworkAgentAPIError> {
        return client.runV1(request,
                            decoder,
                            dumpResponse,
                            responseType)
            .map(\.value).eraseToAnyPublisher()
    }
    
    @available(iOS 15.0.0, *)
    func runV2<T: Decodable>(request: URLRequest,
                             decoder: JSONDecoder,
                             dumpResponse: Bool,
                             logError: Bool,
                             responseType: Common_NetworkClientResponseFormat) async throws -> T {
        return try await client.runV2(request,
                                      decoder,
                                      dumpResponse,
                                      responseType)
    }
}
