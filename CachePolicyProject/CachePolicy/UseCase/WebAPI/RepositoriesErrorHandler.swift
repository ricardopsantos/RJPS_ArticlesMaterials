//
//  Created by Santos, Ricardo Patricio dos on 15/01/2023.
//

import Foundation

public struct RepositoriesErrorHandler {
    public static func handleError(error: Common_FRPNetworkAgentAPIError,
                                   request: Common_FRPNetworkAgentRequestModel,
                                   headerValues: [String: String]?) -> Common_FRPNetworkAgentAPIError {
        var errorMessage: String = ""
        errorMessage += "ServerURL: \(request.serverURL)" + "\n"
        errorMessage += "Path: \(request.path)" + "\n"
        errorMessage += "Error: \(error)" + "\n"
        if let headerValues = headerValues {
            errorMessage += "Header: \(headerValues)" + "\n"
        }
        return error
    }
}
