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
import RxDataSources
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import Extensions
import PointFreeFunctions
import BaseUI

//
// MARK: - Enums & Other Models
//

extension V.CarTrackLoginView {
    enum ScreenLayout {
        case enterUserCredentials
        case enterPassword
        case allFieldsAreValid
        case wrongUserCredencial(errorMessage: String)
        case invalidEmailFormat(errorMessage: String)
        case invalidPasswordFormat(errorMessage: String)
        case invalidEmailFormatAndPasswordFormat(passwordErrorMessage: String, emailErrorMessage: String)
    }
}

//
// MARK: - Interactor (Business Logic)
//

protocol CarTrackLoginBusinessLogicProtocol: BaseInteractorVIPMandatoryBusinessLogicProtocol {
    // Naming convention : func request__XXX__(viewModel: VM.CarTrackLogin.__XXX__.Request)
    func requestScreenInitialState()
    func requestScreenState(request: VM.CarTrackLogin.ScreenState.Request)
    func requestLogin(request: VM.CarTrackLogin.Login.Request)
}

//
// MARK: - Presenter (Presentation Logic)
//

protocol CarTrackLoginPresentationLogicProtocol: BasePresenterVIPProtocol {
    // Naming convention : func present__XXX__(response: VM.CarTrackLogin.__XXX__.Response)
    func presentScreenInitialState(response: VM.CarTrackLogin.ScreenInitialState.Response)
    func presentScreenState(response: VM.CarTrackLogin.ScreenState.Response)
    func presentNextButtonState(response: VM.CarTrackLogin.NextButtonState.Response)
    func presentLogin(response: VM.CarTrackLogin.Login.Response)
}

//
// MARK: - ViewController (Display Logic)
//

protocol CarTrackLoginDisplayLogicProtocol: BaseViewControllerVIPProtocol {
    // Naming convention : func display__XXX__(viewModel: VM.CarTrackLogin.__XXX__.ViewModel)
    func displayScreenInitialState(viewModel: VM.CarTrackLogin.ScreenInitialState.ViewModel)
    func displayScreenState(viewModel: VM.CarTrackLogin.ScreenState.ViewModel)
    func displayLogin(viewModel: VM.CarTrackLogin.Login.ViewModel)
    func displayNextButtonState(viewModel: VM.CarTrackLogin.NextButtonState.ViewModel)
}

//
// MARK: - Router (Routing Logic)
//

// Routing Logic Protocol - all the methods used for routing are kept under this protocol.
protocol CarTrackLoginRoutingLogicProtocol {
    // Naming convention : func routeTo__XXX__MaybeSomeExtraInfo()
    //func routeToTemplateWithParentDataStore()
    //func routeToTemplateWithDataStore()
    func routeToNextScreen()
}

//
// MARK: - DataStore
//

// DataStore : Data Passing Protocol - a protocol that contains the data that needs to be passed to the destination controller.
protocol CarTrackLoginDataPassingProtocol {

    // DataStore
    var dsCarTrackLogin: CarTrackLoginDataStoreProtocol? { get }
}

// DataStore : Implemented by the Interactor, and the Router
protocol CarTrackLoginDataStoreProtocol {
    // must have a reference like [var dataStore: CarTrackLoginDataStoreProtocol?]
    //var dsSomeKindOfModelA: CarTrackLoginDataStoreModelA? { get set }
    //var dsSomeKindOfModelB: CarTrackLoginDataStoreModelB? { get set }

}

//
// MARK: - Models
//

// Other Models

public extension VM {
    enum CarTrackLogin {

        struct NextButtonState {
            struct Request { }
            struct Response {
                let isEnabled: Bool
            }
            struct ViewModel {
                let isEnabled: Bool
            }
        }

        struct ScreenState {
            struct Request {
                let userName: String
                let password: String
                let txtUsernameIsFirstResponder: Bool
                let txtPasswordIsFirstResponder: Bool
            }
            struct Response {
                let emailIsValid: Bool
                let passwordIsValid: Bool
                let invalidCredencials: Bool?
            }
            struct ViewModel {
                let layout: V.CarTrackLoginView.ScreenLayout
            }
        }

        struct Login {
            struct Request { }
            struct Response {
                let success: Bool
                let error: Error?
            }
            struct ViewModel {
                let message: String
                let success: Bool
            }
        }

        struct ScreenInitialState {
            struct Request { }
            struct Response {
                let userName: String
                let password: String
            }
            struct ViewModel {
                let title: String
                let userName: String
                let password: String
                let screenLayout: V.CarTrackLoginView.ScreenLayout
            }
        }
    }
}
