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
    class CartTrackMapRouter: CartTrackMapDataPassingProtocol {
        weak var viewController: VC.CartTrackMapViewController?

     }
}

// MARK: RoutingLogicProtocol

extension R.CartTrackMapRouter: CartTrackMapRoutingLogicProtocol {
    
    func routeToLogin() {
        dismissMe()
    }

    func dismissMe() {
        viewController?.dismissMe()
    }
}

// MARK: BaseRouterProtocol

extension R.CartTrackMapRouter: BaseRouterProtocol {

}
