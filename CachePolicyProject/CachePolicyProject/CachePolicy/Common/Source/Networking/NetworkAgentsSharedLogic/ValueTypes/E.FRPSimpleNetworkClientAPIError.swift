//
//  Created by Ricardo Santos on 21/01/2021.
//

import Foundation

public extension NetworkinNameSpace {
    enum FRPSimpleNetworkClientAPIError: Error {
       case ok // no error
       case cacheNotFound // No error

       case genericError(description: String)
       case parsing(description: String)
       case network(description: String)
       case failedWithStatusCode(code: Int, description: String, bodyCode: String?, bodyMessage: String?)
       case decodeFail(description: String)
    }
}
