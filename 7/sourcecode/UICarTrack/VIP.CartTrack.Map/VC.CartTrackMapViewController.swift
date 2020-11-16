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
struct CartTrackMapViewController_UIViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: VC.CartTrackMapViewController, context: Context) { }
    func makeUIViewController(context: Context) -> VC.CartTrackMapViewController {
        let vc = VC.CartTrackMapViewController()
        //vc.something(viewModel: dashboardVM)
        return vc
    }
}

@available(iOS 13.0.0, *)
struct CartTrackMapViewController_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        return CartTrackMapViewController_UIViewControllerRepresentable()
    }
}

// MARK: - ViewController

extension VC {

    class CartTrackMapViewController: BaseGenericViewControllerVIP<V.CartTrackMapView> {
        var interactor: CartTrackMapBusinessLogicProtocol?
        var router: (CartTrackMapRoutingLogicProtocol &
            CartTrackMapDataPassingProtocol &
            CartTrackMapRoutingLogicProtocol)?

        //
        // MARK: UI Elements
        //

        private lazy var topGenericView: TopBar = {
            let bar = UIKitFactory.topBar(baseController: self, usingSafeArea: false)
            bar.addDismissButton()
            bar.rxSignal_btnDismissTapped
                .asObservable()
                .subscribe(onNext: { (_) in
                    self.router?.routeToLogin()
                }).disposed(by: disposeBag)
            return bar
        }()

        private lazy var reachabilityView: ReachabilityView = {
           return self.addReachabilityView()
        }()

        //
        // MARK: View lifecycle
        //

        override func loadView() {
            super.loadView()
            view.accessibilityIdentifier = self.genericAccessibilityIdentifier
            self.title = "Map"
            topGenericView.setTitle(self.title!)
        }

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if firstAppearance {
                reachabilityView.lazyLoad()
                interactor?.requestScreenInitialState()
                let request = VM.CartTrackMap.MapData.Request()
                interactor?.requestMapData(request: request)
            }
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
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

        override func setup() {
            // This function is called automatically by super BaseGenericView
            let viewController = self
            let interactor = I.CartTrackMapInteractor()
            let presenter  = P.CartTrackMapPresenter()
            let router     = R.CartTrackMapRouter()
            viewController.interactor = interactor
            viewController.router = router
            interactor.presenter  = presenter
            presenter.viewController = viewController
            router.viewController = viewController
        }

        // This function is called automatically by super BaseGenericView
        override func setupViewIfNeed() {
            // Use it to configure stuff on the genericView, depending on the value external/public variables
            // that are set after we instantiate the view controller, but before if has been presented
        }

        // This function is called automatically by super BaseGenericView
        override func setupViewUIRx() {
            genericView.rxFilter.asObserver().bind { [weak self] (search) in
                guard let self = self else { return }
                guard let search = search else { return }
                guard self.isVisible else { return }
                let viewModel = VM.CartTrackMap.MapDataFilter.Request(filter: search)
                self.interactor?.requestMapDataFilter(viewModel: viewModel)
            }.disposed(by: disposeBag)
        }

        // This function is called automatically by super BaseGenericView
        override func setupNavigationUIRx() {
            // Add options to navigation bar
        }
    }
}

// MARK: Public Misc Stuff

extension VC.CartTrackMapViewController {

}

// MARK: Private Misc Stuff

private extension VC.CartTrackMapViewController {

}

// MARK: DisplayLogicProtocol

extension VC.CartTrackMapViewController: CartTrackMapDisplayLogicProtocol {

    func displayMapDataFilter(viewModel: VM.CartTrackMap.MapDataFilter.ViewModel) {
        genericView.setupWith(mapDataFilter: viewModel)
    }

    func displayMapData(viewModel: VM.CartTrackMap.MapData.ViewModel) {
        genericView.setupWith(mapData: viewModel)
    }

    func displayScreenInitialState(viewModel: VM.CartTrackMap.ScreenInitialState.ViewModel) {

    }
}
