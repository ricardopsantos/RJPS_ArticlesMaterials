//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RxCocoa
import RxSwift
import DevTools
import PointFreeFunctions
//
import Extensions

open class BaseGenericViewControllerVIP<T: StylableView>: BaseViewControllerVIP {

    deinit {
        if genericView != nil {
            genericView.removeFromSuperview()
        }
    }

    public var genericView: T!

    open override func loadView() {
        super.loadView()
        // Setup Generic View
        setup()
        genericView = T()
        view.addSubview(genericView)
        genericView.autoLayout.edgesToSuperview()
        setupViewUIRx()
    }

    open func setup() {
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViewIfNeed()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationUIRx()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.executeWithDelay(delay: 0.1) { [weak self] in
            self?.firstAppearance = false
        }
    }

    open func setupViewIfNeed() {
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }

    open func setupNavigationUIRx() {
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }

    open func setupViewUIRx() {
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }
}
