//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RxCocoa
import RxSwift

public protocol NetworkingOperationsUtilsProtocol: class {

    // If there is internet; execute the code in the block. If not, present a warning
    var networkingUtilsExistsInternetConnection: Bool { get }

    func networkingUtilsDownloadImage(imageURL: String, onFail: UIImage?, completion: @escaping (UIImage?) -> Void)

}
