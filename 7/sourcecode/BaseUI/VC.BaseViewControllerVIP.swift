//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RxSwift
import RJSLibUFBase
//
import BaseConstants
import AppTheme
import DevTools
import BaseCore
import BaseDomain

open class BaseViewControllerVIP: UIViewController, BaseViewControllerVIPProtocol {

    public var disposeBag: DisposeBag = DisposeBag()
    public var firstAppearance = true

    deinit {
        DevTools.Log.logDeInit("\(self.className) was killed")
        NotificationCenter.default.removeObserver(self)
    }

    open override func loadView() {
        super.loadView()
        doViewLifeCycle()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.executeWithDelay(delay: 0.1) { [weak self] in
            guard let self = self else { return }
            self.firstAppearance = false
        }
    }
    
    open func displayStatus(viewModel: BaseDisplayLogicModels.Status) {
        var message = "\(viewModel.title)"
        if !viewModel.message.isEmpty {
            message = message.isEmpty ? viewModel.message : "\(message)\n\n\(viewModel.message)"
        }
        displayMessage(message, type: .success)
    }

    open func displayLoading(viewModel: BaseDisplayLogicModels.Loading) {
        setActivityState(viewModel.isLoading)
    }

    open func displayError(viewModel: BaseDisplayLogicModels.Error) {
        var message = "\(viewModel.title)"
        if !viewModel.message.isEmpty {
            message = message.isEmpty ? viewModel.message : "\(message)\n\n\(viewModel.message)"
        }
        displayMessage(message, type: .error)
    }

    open func setupColorsAndStyles() {
        DevTools.Log.error(DevTools.Strings.notImplemented)
    }

    open func prepareLayoutCreateHierarchy() {
        // What should this function be used for? Add stuff to the view zone....
        // ...
        // addSubview(scrollView)
        // scrollView.addSubview(stackViewVLevel1)
        // ...
        //
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }

    open func prepareLayoutBySettingAutoLayoutsRules() {
        // What should this function be used for? Setup layout rules zone....
        // ...
        // someView.autoLayout.widthToSuperview()
        // someView.autoLayout.bottomToSuperview()
        // ...
        //
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }

    open func prepareLayoutByFinishingPrepareLayout() {
        // What should this function be used for? Extra stuff zone (not included in [prepareLayoutCreateHierarchy]
        // and [prepareLayoutBySettingAutoLayoutsRules]
        // ...
        // table.separatorColor = .clear
        // table.rx.setDelegate(self).disposed(by: disposeBag)
        // label.textAlignment = .center
        // ...
        DevTools.Log.warning("\(self.className) : \(DevTools.Strings.overrideMe.rawValue)")
    }
}

//
// MARK: - BaseViewProtocol
//

extension BaseViewControllerVIP: BaseViewProtocol {
    public func displayMessage(_ message: String, type: AlertType) {
        if let messagesManager = DIRootAssemblyResolver.messagesManager {
            messagesManager.displayMessage(message, type: type)
        }
    }
}

//
// MARK: - Private
//

private extension BaseViewControllerVIP {

    func setActivityState(_ state: Bool) {
        if state {
            self.view.rjs.startActivityIndicator()
        } else { self.view.rjs.stopActivityIndicator() }
    }

    func doViewLifeCycle() {
        prepareLayoutCreateHierarchy()           // DONT CHANGE ORDER
        prepareLayoutBySettingAutoLayoutsRules() // DONT CHANGE ORDER
        prepareLayoutByFinishingPrepareLayout()  // DONT CHANGE ORDER
        setupColorsAndStyles()                   // DONT CHANGE ORDER
    }
}
