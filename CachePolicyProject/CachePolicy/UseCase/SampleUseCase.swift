import Foundation
import Combine

class SampleUseCase {
    
    private init() { }
    public static var shared = SampleUseCase()
    public let webAPI: WebAPIProtocol = WebAPI()
 
    typealias ResponseWithCacheMaybe = AnyPublisher<ResponseDto.EmployeeServiceAvailability, AppErrors>
    func requestWithoutCache(param: String) -> ResponseWithCacheMaybe {
        let requestDto = RequestDto.Employee(someParam: param)
        let apiRequest = webAPI.requestSampleJSON(requestDto)
            //.delay(seconds: 1) // Simulate a bigger API response delay
        return apiRequest.mapError({$0.toAppError}).eraseToAnyPublisher()
    }
    
    func requestWithCacheMaybe(param: String, cachePolicy: CachePolicy) -> ResponseWithCacheMaybe {
        let apiRequest = requestWithoutCache(param: param)
        let serviceKey = #function
        let serviceParams: [String] = [param]
        let apiResponseType = ResponseDto.EmployeeServiceAvailability.self
        return NetworkinNameSpace.NetworkingUtils.genericRequestWithCache(apiRequest,
                                                                          apiResponseType,
                                                                          cachePolicy,
                                                                          serviceKey,
                                                                          serviceParams)
    }
}
