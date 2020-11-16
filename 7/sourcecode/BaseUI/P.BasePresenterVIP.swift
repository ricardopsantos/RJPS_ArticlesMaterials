//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

import DevTools

open class BasePresenterVIP: BasePresenterVIPProtocol {
    public init () {}
    open weak var baseViewController: BaseViewControllerVIPProtocol? {
        fatalError("Override me on pressenter")
    }
    deinit {
        DevTools.Log.logDeInit("\(BasePresenterVIP.self) was killed")
        NotificationCenter.default.removeObserver(self)
    }
}
