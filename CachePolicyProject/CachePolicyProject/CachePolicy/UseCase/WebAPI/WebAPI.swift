//
//  Created by Santos, Ricardo Patricio dos  on 05/12/2021.
//

import Foundation
import Combine

//
// MARK: - WebAPIProtocol
//

public protocol WebAPIProtocol {
    typealias SampleJSONResponse = AnyPublisher<ResponseDto.EmployeeServiceAvailability, Common_FRPNetworkAgentAPIError>
    func requestSampleJSON(_ requestDto: RequestDto.Employee) -> SampleJSONResponse
}

//
// MARK: - WebAPI
//

public class WebAPI: Common_FRPNetworkAgentProtocol {
    public var client = Common_FRPSimpleNetworkAgent(session: URLSession.shared)
    public init() { }
}

//
// MARK: - WebAPI WebAPIProtocol implementation
//

extension WebAPI: WebAPIProtocol {
    public func requestSampleJSON(_ requestDto: RequestDto.Employee) -> SampleJSONResponse {
        let serverURL = "https://gist.githubusercontent.com"
        let path = "ricardopsantos/10a31da1c6981acd216a93cb040524b9/raw/8f0f03e6bdfe0dd522ff494022f3aa7a676e882f/Article_13_G8.json"
        let request = Common_FRPNetworkAgentRequestModel(path: path,
                                                         httpMethod: .get,
                                                         httpBody: nil,
                                                         headerValues: nil,
                                                         serverURL: serverURL,
                                                         responseType: .json)
        return client.runV1(request.urlRequest!, JSONDecoder(), false, request.responseFormat)
            .map(\.value)
            .mapError { error in
            return RepositoriesErrorHandler.handleError(error: error, request: request, headerValues: nil)
        }.eraseToAnyPublisher()
    }
}
