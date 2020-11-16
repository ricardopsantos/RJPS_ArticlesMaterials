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
struct GalleryAppS1ViewController_UIViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: VC.GalleryAppS1ViewController, context: Context) { }
    func makeUIViewController(context: Context) -> VC.GalleryAppS1ViewController {
        let vc = VC.GalleryAppS1ViewController()
        //vc.something(viewModel: dashboardVM)
        return vc
    }
}

@available(iOS 13.0.0, *)
struct GalleryAppS1ViewController_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        return GalleryAppS1ViewController_UIViewControllerRepresentable()
    }
}

// MARK: - ViewController

extension VC {

    public class GalleryAppS1ViewController: BaseGenericViewControllerVIP<V.GalleryAppS1View> {

        deinit {
            DevTools.Log.logDeInit("\(self.className) was killed")
            NotificationCenter.default.removeObserver(self)
        }
        
        private var interactor: GalleryAppS1BusinessLogicProtocol?
        var router: (GalleryAppS1RoutingLogicProtocol & GalleryAppS1RoutingLogicProtocol)?

        private lazy var reachabilityView: ReachabilityView = {
           return self.addReachabilityView()
        }()

        private lazy var topGenericView: TopBar = {
            UIKitFactory.topBar(baseController: self, usingSafeArea: false)
        }()

        //
        // MARK: View lifecycle
        //

        // Order in View life-cycle : 2
        public override func loadView() {
            super.loadView()
            view.accessibilityIdentifier = self.genericAccessibilityIdentifier
            reachabilityView.load()
        }

        // Order in View life-cycle : 4
        public override func viewDidLoad() {
            super.viewDidLoad()
            if DevTools.onSimulator {
                DispatchQueue.executeOnce(token: "\(VC.GalleryAppS1ViewController.self).info") {
                    let message = "Gallery App" + "\n\n"
                    DevTools.makeToast(message, duration: 10)
                }
            }
        }

        // Order in View life-cycle : 6
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if firstAppearance {
                interactor?.requestScreenInitialState()
                topGenericView.setTitle("Show me kitties!")
            }
        }

        // Order in View life-cycle : 9
        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }

        //
        // MARK: Dark Mode
        //

        // Order in View life-cycle : 8
        public override func setupColorsAndStyles() {
            //super.setupColorsAndStyles()
            // Setup UI on dark mode (if needed)
        }

        //
        // MARK: Mandatory methods
        //

        // Order in View life-cycle : 1
        public override func setup() {
            // This function is called automatically by super BaseGenericView
            let viewController = self
            let interactor = I.GalleryAppS1Interactor()
            let presenter  = P.GalleryAppS1Presenter()
            let router     = R.GalleryAppS1Router()
            viewController.interactor = interactor
            viewController.router    = router
            interactor.presenter     = presenter
            presenter.viewController = viewController
            router.viewController    = viewController
        }

        // Order in View life-cycle : 5
        // This function is called automatically by super BaseGenericView
        public override func setupViewIfNeed() {
            // Use it to configure stuff on the genericView, depending on the value external/public variables
            // that are set after we instantiate the view controller, but before if has been presented
        }

        // Order in View life-cycle : 3
        // This function is called automatically by super BaseGenericView
        public override func setupViewUIRx() {

            genericView.rxFilter.asObserver().bind { [weak self] (search) in
                guard let self = self else { return }
                guard let search = search else { return }
                guard self.isVisible else { return }
                let request = VM.GalleryAppS1.SearchByTag.Request(tag: search)
                self.interactor?.requestSearchByTag(request: request)
            }.disposed(by: disposeBag)

            genericView.rxLoadMore.asObserver().bind { [weak self] (value) in
                guard let self = self else { return }
                //guard let search = search else { return }
                guard self.isVisible else { return }
                if value ?? false {
                    let request = VM.GalleryAppS1.LoadMore.Request()
                    self.interactor?.requestLoadMore(request: request)
                }
            }.disposed(by: disposeBag)

        }

        // Order in View life-cycle : 7
        // This function is called automatically by super BaseGenericView
        public override func setupNavigationUIRx() {
            // Add options to navigation bar
        }

        public override func prepareLayoutCreateHierarchy() {
            super.prepareLayoutCreateHierarchy()
        }

        public override func prepareLayoutBySettingAutoLayoutsRules() {
            super.prepareLayoutBySettingAutoLayoutsRules()
        }

        public override func prepareLayoutByFinishingPrepareLayout() {
            super.prepareLayoutByFinishingPrepareLayout()
        }
    }
}

// MARK: Private Misc Stuff

private extension VC.GalleryAppS1ViewController {

}

// MARK: DisplayLogicProtocol

extension VC.GalleryAppS1ViewController: GalleryAppS1DisplayLogicProtocol {

    func displayLoadMore(viewModel: VM.GalleryAppS1.LoadMore.ViewModel) {
        genericView.setupWith(loadMore: viewModel)
    }

    func displaySearchByTag(viewModel: VM.GalleryAppS1.SearchByTag.ViewModel) {
        // Setting up the view, option 1 : passing the view model
        genericView.setupWith(searchByTag: viewModel)
    }

    func displayScreenInitialState(viewModel: VM.GalleryAppS1.ScreenInitialState.ViewModel) {
        genericView.setupWith(screenInitialState: viewModel)
    }
}
