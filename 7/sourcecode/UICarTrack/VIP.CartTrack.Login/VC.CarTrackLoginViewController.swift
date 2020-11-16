//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//
import Foundation
import UIKit
import SwiftUI
//
import RxCocoa
import RxSwift
import TinyConstraints
import Material
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

// MARK: - Preview

@available(iOS 13.0.0, *)
struct CarTrackLoginViewController_UIViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: VC.CarTrackLoginViewController, context: Context) { }
    func makeUIViewController(context: Context) -> VC.CarTrackLoginViewController {
        let vc = VC.CarTrackLoginViewController()
        //vc.something(viewModel: dashboardVM)
        return vc
    }
}

@available(iOS 13.0.0, *)
struct CarTrackLoginViewController_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        return CarTrackLoginViewController_UIViewControllerRepresentable()
    }
}

// MARK: - ViewController

extension VC {

    public class CarTrackLoginViewController: BaseGenericViewControllerVIP<V.CarTrackLoginView> {
        private var interactor: CarTrackLoginBusinessLogicProtocol?
        var router: (CarTrackLoginRoutingLogicProtocol &
            CarTrackLoginDataPassingProtocol &
            CarTrackLoginRoutingLogicProtocol)?

        private lazy var reachabilityView: ReachabilityView = {
           return self.addReachabilityView()
        }()

        //
        // MARK: View lifecycle
        //

        public override func loadView() {
            super.loadView()
            self.title = Messages.login.localised
        }

        public override func viewDidLoad() {
            super.viewDidLoad()
            if DevTools.onSimulator {
                DispatchQueue.executeOnce(token: "\(VC.CarTrackLoginViewController.self).info") {
                    let mail = AppConstants.Misc.sampleEmail
                    let pass = AppConstants.Misc.sampleEmail
                    var message = "Login + Maps" + "\n\n"
                    message = "\(message)User: \(mail)" + "\n"
                    message = "\(message)Password: \(pass)" + "\n"
                    DevTools.makeToast(message, duration: 10)
                }
            }
        }

        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if firstAppearance {
                interactor?.requestScreenInitialState()
            }
        }

        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            reachabilityView.lazyLoad()
        }

        //
        // MARK: Dark Mode
        //

        public override func setupColorsAndStyles() {
            //super.setupColorsAndStyles()
            // Setup UI on dark mode (if needed)
        }

        //
        // MARK: Mandatory methods
        //

        public override func setup() {
            // This function is called automatically by super BaseGenericView
            let viewController = self
            let interactor = I.CarTrackLoginInteractor()
            let presenter  = P.CarTrackLoginPresenter()
            let router     = R.CarTrackLoginRouter()
            viewController.interactor = interactor
            viewController.router = router
            interactor.presenter  = presenter
            presenter.viewController = viewController
            router.viewController = viewController
            router.dsCarTrackLogin = interactor
        }

        private lazy var topGenericView: TopBar = {
            let bar = UIKitFactory.topBar(baseController: self, usingSafeArea: false)
            bar.setTitle(Messages.welcome.localised)
            return bar
        }()

        // This function is called automatically by super BaseGenericView
        public override func setupViewIfNeed() {
            // Use it to configure stuff on the genericView, depending on the value external/public variables
            // that are set after we instantiate the view controller, but before if has been presented
        }

        // This function is called automatically by super BaseGenericView
        public override func setupViewUIRx() {

            //
            // User and password
            //
            let observable1 = genericView.rxTxtPassword.value.asObservable()
                .debounce(.milliseconds(AppConstants.Rx.textFieldsDefaultDebounce), scheduler: MainScheduler.instance)
            let observable2 = genericView.rxTxtUsername.value.asObservable()
                .debounce(.milliseconds(AppConstants.Rx.textFieldsDefaultDebounce), scheduler: MainScheduler.instance)
            Observable.combineLatest(observable1, observable2).asObservable().bind { [weak self] (password, userName) in
                guard let self = self else { return }
                guard self.isVisible else { return }
                guard let password = password else { return }
                guard let userName = userName else { return }
                let request = VM.CarTrackLogin.ScreenState.Request(userName: userName,
                                                                   password: password,
                                                                   txtUsernameIsFirstResponder: self.genericView.txtUsernameIsFirstResponder,
                                                                   txtPasswordIsFirstResponder: self.genericView.txtPasswordIsFirstResponder)
                self.interactor?.requestScreenState(request: request)
            }.disposed(by: disposeBag)

            genericView.rxBtnLoginTap
                .do(onNext: { [weak self] in
                    self?.genericView.subViewsWith(tag: UIKitViewFactoryElementTag.label.rawValue, recursive: true).forEach({ (some) in
                           (some as? UITextField)?.resignFirstResponder()
                       })
                    let request = VM.CarTrackLogin.Login.Request()
                    self?.interactor?.requestLogin(request: request)
                })
                .subscribe()
                .disposed(by: disposeBag)
        }

        // This function is called automatically by super BaseGenericView
        public override func setupNavigationUIRx() {
            // Add options to navigation bar
        }
    }
}

// MARK: Public Misc Stuff

extension VC.CarTrackLoginViewController {

}

// MARK: Private Misc Stuff

private extension VC.CarTrackLoginViewController {

}

// MARK: DisplayLogicProtocol

extension VC.CarTrackLoginViewController: CarTrackLoginDisplayLogicProtocol {

    func displayLogin(viewModel: VM.CarTrackLogin.Login.ViewModel) {
        if viewModel.success {
            router?.routeToNextScreen()
        } else {
            DevTools.assert(false, message: DevTools.Strings.notPredicted.rawValue)
        }
    }

    func displayScreenState(viewModel: VM.CarTrackLogin.ScreenState.ViewModel) {
        // Setting up the view, option 1 : passing the view model
        genericView.setupWith(screenState: viewModel)
    }

    func displayNextButtonState(viewModel: VM.CarTrackLogin.NextButtonState.ViewModel) {
        genericView.setupWith(nextButtonState: viewModel)
    }

    func displayScreenInitialState(viewModel: VM.CarTrackLogin.ScreenInitialState.ViewModel) {
        genericView.setupWith(screenInitialState: viewModel)
    }
}
