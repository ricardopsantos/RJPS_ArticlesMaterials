//
//  Created by Ricardo Santos on 21/01/2021.
//

import Foundation

// Used on [SimpleNetworkClient] and [FRPSimpleNetworkAgent]

public extension NetworkinNameSpace {
     enum HttpMethod: String {
        case get    = "GET"
        case post   = "POST"
        case put    = "PUT"
        case delete = "DELETE"
    }
}
