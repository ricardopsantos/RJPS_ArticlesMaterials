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

/**
 Agent is a promise-based HTTP client. It fulfils and configures requests by passing a single URLRequest object to it.
 The agent automatically transforms JSON data into a Codable value and returns an AnyPublisher instance:
 
 1 - Response<T> carries both parsed value and a URLResponse instance. The latter can be used for status code validation and logging.
 2 - The run<T>() method is the single entry point for requests execution. It accepts a URLRequest instance that fully
 describes the request configuration. The decoder is optional in case custom JSON parsing is needed.
 3 - Create data task as a Combine publisher.
 4 - Parse JSON data. We have constrained T to be Decodable in the run<T>() method declaration.
 5 - Create the Response<T> object and pass it downstream. It contains the parsed value and the URL response.
 6 - Deliver values on the main thread.
 7 - Erase publisher’s type and return an instance of AnyPublisher.
 */

extension NetworkinNameSpace {
    public class FRPSimpleNetworkAgent {
        private (set) var session: URLSession
        public init() {
            // self.session = .shared
            self.session = URLSession.shared
        }
        public init(session: URLSession) {
            self.session = session
        }
    }
    public struct Response<T: Decodable> {
        public let value: T
        public let response: Any
        public init(value: T, response: Any) {
            self.value = value
            self.response = response
        }
    }
}

public extension Common_FRPSimpleNetworkAgent {
    
    // 2
    func runV1<T>(_ request: URLRequest,
                  _ decoder: JSONDecoder,
                  _ dumpResponse: Bool,
                  _ responseFormat: Common_NetworkClientResponseFormat) -> AnyPublisher<NetworkinNameSpace.Response<T>, Common_FRPNetworkAgentAPIError> where T: Decodable {
        
        return session
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> NetworkinNameSpace.Response<T> in
                let responseEval = Self.responseIsValid(result.response)
                guard responseEval.isValid else {
                    // We can received a status code like 404 (not found), but with a ussefull body message with
                    // extra information
                    let bodyCode    = Self.extractFieldMaybe(field: "code", data: result.data)
                    let bodyMessage = Self.extractFieldMaybe(field: "message", data: result.data)
                    if bodyCode != nil || bodyMessage != nil {
                        throw Common_FRPNetworkAgentAPIError.failedWithStatusCode(code: responseEval.1,
                                                                                   description: responseEval.error.localizedDescription,
                                                                                   bodyCode: bodyCode,
                                                                                   bodyMessage: bodyMessage)
                    }
                    throw responseEval.error
                }
                
                let value: T = try Self.decode(result.data, decoder, responseFormat)
                return NetworkinNameSpace.Response(value: value, response: result.response)  // 5
                
            }
            .mapError { error in
                if let error = error as? Common_FRPNetworkAgentAPIError {
                    return error
                } else {
                    return Common_FRPNetworkAgentAPIError.network(description: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()           // 7
        
    }
    
    @available(iOS 15.0.0, *)
    func runV2<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder,
        _ dumpResponse: Bool,
        _ responseFormat: Common_NetworkClientResponseFormat) async throws -> T {
            let (data, urlResponse) = try await session.data(for: request)
            let responseEval = Self.responseIsValid(urlResponse)
            guard responseEval.isValid else {
                // We can received a status code like 404 (not found), but with a ussefull body message with
                // extra information
                let bodyCode    = Self.extractFieldMaybe(field: "code", data: data)
                let bodyMessage = Self.extractFieldMaybe(field: "message", data: data)
                if bodyCode != nil || bodyMessage != nil {
                    throw Common_FRPNetworkAgentAPIError.failedWithStatusCode(code: responseEval.1,
                                                                               description: responseEval.error.localizedDescription,
                                                                               bodyCode: bodyCode,
                                                                               bodyMessage: bodyMessage)
                }
                throw responseEval.error
            }
            do {
                return try Self.decode(data, decoder, responseFormat)
            } catch {
                if let error = error as? Common_FRPNetworkAgentAPIError {
                    throw error
                } else {
                    throw Common_FRPNetworkAgentAPIError.network(description: error.localizedDescription)
                }
            }
        }
}

//
// MARK : Private shared code
//

fileprivate extension Common_FRPSimpleNetworkAgent {
    
    func debugStringWith(_ requestDebugDump: String, _ error: Error) -> String {
        let result = """
        # Request failed
        # \(requestDebugDump)
        # [\(error.localizedDescription)]
        # [\(error)]
        """
        return result
    }
    
    static func extractFieldMaybe(field: String, data: Data) -> String? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
            if let value = json[field] { return "\(value)" }
            if let value = json[field.uppercased()] { return "\(value)" }
            if let value = json[field.lowercased()] { return "\(value)" }
        }
        return nil
    }
    
    static func responseIsValid(_ urlResponse: Any?) -> (isValid: Bool, statusCode: Int, error: Common_FRPNetworkAgentAPIError) {
        var statusCode: Int = 200
        if let httpResponse = urlResponse as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
        }
        guard 200...299 ~= statusCode else {
            let defaultErrorDescription = "urlResponse: \(urlResponse ?? "nil or empty")"
            return (false, statusCode, Common_FRPNetworkAgentAPIError.failedWithStatusCode(code: statusCode,
                                                                                           description: defaultErrorDescription,
                                                                                           bodyCode: nil,
                                                                                           bodyMessage: nil))
        }
        return (true, statusCode, .ok)
    }
    
    static func decode<T: Decodable>(_ data: Data, _ decoder: JSONDecoder, _ responseFormat: Common_NetworkClientResponseFormat) throws -> T {
        switch responseFormat {
        case .json:
            return try decoder.decode(T.self, from: data) // 4
        case .csv:
            let data = try NetworkinNameSpace.NetworkAgentUtils.parseCSV(data: data)
            return try decoder.decode(T.self, from: data)
        }
    }
}
