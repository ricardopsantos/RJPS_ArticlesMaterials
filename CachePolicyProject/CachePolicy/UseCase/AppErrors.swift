//
//  Created by Ricardo Santos on 22/01/2021.
//

import Foundation

enum AppErrors: Error, Equatable, Hashable {
    case ok // No error
    case cacheNotFound // No error

    case genericError(devMessage: String)
    case recordNotFound
    case parsing(description: String)    // For parse errors
    case network(description: String)    // For network error errors
    case failedWithStatusCode(code: Int,
                              description: String,
                              bodyCode: String?,
                              bodyMessage: String?) // For generic status code errors
    case noInternetConnection
}

extension Common_FRPNetworkAgentAPIError {
    var toAppError: AppErrors {
        switch self {
        case .ok:                                    return .ok
        case .cacheNotFound:                         return .ok
        case .genericError:                          return .genericError(devMessage: "")
        case .parsing(description: let description): return .parsing(description: description)
        case .network(description: let description): return .network(description: description)
        case .decodeFail:                            return .genericError(devMessage: "decodeFail")
        case .failedWithStatusCode(code: let code, description: let description, bodyCode: let bodyCode, bodyMessage: let bodyMessage):
            return .failedWithStatusCode(code: code, description: description, bodyCode: bodyCode, bodyMessage: bodyMessage)
        }
    }
}
