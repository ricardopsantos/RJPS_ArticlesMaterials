//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import AppResources

// MARK: - Interactor - Business Logic

public protocol BaseInteractorVIPMandatoryBusinessLogicProtocol {
    var basePresenter: BasePresenterVIPProtocol? { get }
    func requestScreenInitialState()
}

// MARK: - Presenter - PresentationLogic

/// [BasePresentationLogicProtocol] && [BaseDisplayLogicProtocol] must match
public protocol BasePresenterVIPProtocol: class {
    var baseViewController: BaseViewControllerVIPProtocol? { get }
    func presentLoading(response: BaseDisplayLogicModels.Loading)
    func presentError(response: BaseDisplayLogicModels.Error)
    func presentStatus(response: BaseDisplayLogicModels.Status)

    // Helper...
    func presentErrorGeneric()

}

/// Default implementation....
public extension BasePresenterVIPProtocol {
    func presentStatus(response: BaseDisplayLogicModels.Status) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = response
            self?.baseViewController?.displayStatus(viewModel: viewModel)
        }

    }

    func presentError(response: BaseDisplayLogicModels.Error) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = response
            self?.baseViewController?.displayError(viewModel: viewModel)
        }

    }

    func presentErrorGeneric() {
        DispatchQueue.main.async { [weak self] in
            let response = BaseDisplayLogicModels.Error(title: Messages.alert.localised, message: Messages.pleaseTryAgainLater.localised)
            self?.presentError(response: response)
        }
    }

    func presentLoading(response: BaseDisplayLogicModels.Loading) {
        DispatchQueue.main.async { [weak self] in
            if let viewController = self?.baseViewController as? UIViewController {
                if response.isLoading {
                    viewController.view.rjs.startActivityIndicator()
                } else {
                    viewController.view.rjs.stopActivityIndicator()
                }
            }
        }

    }
}

// MARK: - ViewController - DisplayLogic

public protocol BaseViewControllerVIPProtocol: class {
    func displayLoading(viewModel: BaseDisplayLogicModels.Loading)
    func displayError(viewModel: BaseDisplayLogicModels.Error)
    func displayStatus(viewModel: BaseDisplayLogicModels.Status)
}

// MARK: Models

public struct BaseDisplayLogicModels {

    public struct Error {
        public let title: String
        public let message: String
        public var shouldDisplay: Bool = true
        
        public init(title: String, message: String="") {
            self.title = title
            self.message = message
        }
    }

    public struct Status {
        public let title: String
        public let message: String
        public init(title: String="", message: String="") {
            self.title = title
            self.message = message
        }
    }

    public struct Loading {
        public let isLoading: Bool
        public let message: String
        public init(isLoading: Bool, message: String="") {
            self.isLoading = isLoading
            self.message = message
        }
    }
}
