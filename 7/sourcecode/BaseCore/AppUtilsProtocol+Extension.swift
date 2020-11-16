//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RJSLibUFBase
//
import BaseDomain

public extension NetworkingOperationsUtilsProtocol {
    
    func networkingUtilsDownloadImage(imageURL: String, onFail: UIImage?=nil, completion: @escaping (UIImage?) -> Void) {
        RJSLib.BasicNetworkClient.downloadImageFrom(imageURL, caching: .hotElseCold) { (image) in completion(image ?? onFail) }
    }
    
    var networkingUtilsExistsInternetConnection: Bool {
        return RJS_Utils.existsInternetConnection
    }    
}
