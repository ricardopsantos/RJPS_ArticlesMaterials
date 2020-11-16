//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//
import Foundation
import UIKit
//
import RxCocoa
import RxSwift
import TinyConstraints
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import Extensions
import PointFreeFunctions
import AppResources
import BaseUI

//
// After the interactor produces some results, it passes the response to the presenter.
// The presenter then marshal the response into view models suitable for display.
// It then passes the view models back to the view controller for display to the user.
//
// Now that we have the Response from the Interactor, it’s time to format it
// into a ViewModel and pass the result back to the ViewController. Presenter will be
// in charge of the presentation logic. This component decides how the data will be presented to the user.
//

extension P {
    class CarTrackLoginPresenter: BasePresenterVIP {
        weak var viewController: (CarTrackLoginDisplayLogicProtocol)?

        override weak var baseViewController: BaseViewControllerVIPProtocol? {
            return viewController
        }
    }
}

// MARK: PresentationLogicProtocol

extension P.CarTrackLoginPresenter {

}

// MARK: PresentationLogicProtocol

extension P.CarTrackLoginPresenter: CarTrackLoginPresentationLogicProtocol {

    func presentLogin(response: VM.CarTrackLogin.Login.Response) {
        if response.success {
            // All cool!
            let viewModel = VM.CarTrackLogin.Login.ViewModel(message: "", success: true)
            viewController?.displayLogin(viewModel: viewModel)
        } else if let error = response.error, let appCode = error.appCode, appCode == .invalidCredentials {
            // Wrong password
            let viewModel = VM.CarTrackLogin.ScreenState.ViewModel(layout: .wrongUserCredencial(errorMessage: appCode.localisedMessageForView))
            viewController?.displayScreenState(viewModel: viewModel)
        } else if let error = response.error {
            // Other type of error....
            let viewModel = BaseDisplayLogicModels.Error(title: Messages.alert.localised, message: error.localisedMessageForView)
            viewController?.displayError(viewModel: viewModel)
        } else {
            DevTools.assert(false, message: DevTools.Strings.notPredicted.rawValue, forceFix: true)
        }
    }

    func presentNextButtonState(response: VM.CarTrackLogin.NextButtonState.Response) {
        let viewModel = VM.CarTrackLogin.NextButtonState.ViewModel(isEnabled: response.isEnabled)
        viewController?.displayNextButtonState(viewModel: viewModel)
    }

    // Used By Interactor (exclusively)
    func presentScreenInitialState(response: VM.CarTrackLogin.ScreenInitialState.Response) {
        let userName = response.userName
        let password = response.password
        let screenLayout: V.CarTrackLoginView.ScreenLayout = .enterUserCredentials
        let title = Messages.welcome.localised
        let viewModel = VM.CarTrackLogin.ScreenInitialState.ViewModel(title: title,
                                                                      userName: userName,
                                                                      password: password,
                                                                      screenLayout: screenLayout)
        viewController?.displayScreenInitialState(viewModel: viewModel)
    }

    // Used By Interactor (exclusively)
    func presentScreenState(response: VM.CarTrackLogin.ScreenState.Response) {

        let emailIsValid    = response.emailIsValid
        let passwordIsValid = response.passwordIsValid
        var layout: V.CarTrackLoginView.ScreenLayout = .allFieldsAreValid
        if emailIsValid && !passwordIsValid {
            //
            // Invalid password
            //
            layout = .invalidPasswordFormat(errorMessage: Messages.invalidPassword.localised)
        } else if !emailIsValid && passwordIsValid {
            //
            // Invalid email
            //
            layout = .invalidEmailFormat(errorMessage: Messages.invalidEmail.localised)
        } else if !emailIsValid && !passwordIsValid {
            //
            // Invalid email and password
            //
            layout = .invalidEmailFormatAndPasswordFormat(passwordErrorMessage: Messages.invalidPassword.localised, emailErrorMessage: Messages.invalidEmail.localised)
        } else {
            //
            // All valid
            //
            layout = .allFieldsAreValid
        }
        let viewModel = VM.CarTrackLogin.ScreenState.ViewModel(layout: layout)
        viewController?.displayScreenState(viewModel: viewModel)
    }
}
