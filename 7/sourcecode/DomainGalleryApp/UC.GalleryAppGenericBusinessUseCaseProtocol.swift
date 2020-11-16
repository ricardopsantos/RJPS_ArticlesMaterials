//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RJSLibUFNetworking
import RxSwift
//

/**
Use case Protocol for things related with __app generic business__
 */

public protocol GalleryAppGenericBusinessUseCaseProtocol: class {
    func download(_ request: GalleryAppModel.ImageInfo) -> Observable<UIImage>
}
