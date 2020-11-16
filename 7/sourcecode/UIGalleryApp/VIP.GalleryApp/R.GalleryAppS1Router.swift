//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RxCocoa
import RxSwift
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import Extensions
import PointFreeFunctions
import BaseUI

extension R {
    class GalleryAppS1Router {
        deinit {
            DevTools.Log.logDeInit("\(GalleryAppS1Router.self) was killed")
            NotificationCenter.default.removeObserver(self)
        }
        weak var viewController: VC.GalleryAppS1ViewController?
     }
}

// MARK: RoutingLogicProtocol

extension R.GalleryAppS1Router: GalleryAppS1RoutingLogicProtocol {
    func dismissMe() {
        viewController?.dismissMe()
    }
}

// MARK: BaseRouterProtocol

extension R.GalleryAppS1Router: BaseRouterProtocol {

}
