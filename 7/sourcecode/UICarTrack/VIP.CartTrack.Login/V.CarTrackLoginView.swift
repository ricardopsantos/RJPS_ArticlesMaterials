//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
import SwiftUI
//
import RxCocoa
import RxSwift
import RxDataSources
import TinyConstraints
import SkyFloatingLabelTextField
import Material
import Motion
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import Extensions
import PointFreeFunctions
import BaseUI
import AppResources
import Lottie

// MARK: - Preview

@available(iOS 13.0.0, *)
struct CarTrackLoginView_UIViewRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: V.CarTrackLoginView, context: Context) { }
    func makeUIView(context: Context) -> V.CarTrackLoginView {
        let some = V.CarTrackLoginView()
        return some
    }
}

@available(iOS 13.0.0, *)
struct CarTrackLoginView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        CarTrackLoginView_UIViewRepresentable()
    }
}

// MARK: - View

extension V {
    public class CarTrackLoginView: BaseGenericViewVIP {

        deinit {
            DevTools.Log.logDeInit("\(self.className) was killed")
            NotificationCenter.default.removeObserver(self)
        }

        // MARK: - UI Elements (Private and lazy by default)

        // Lottie view
        private var animationView: AnimationView!

        private lazy var scrollView: UIScrollView = {
            UIKitFactory.scrollView()
        }()

        private lazy var stackViewVLevel1: UIStackView = {
            UIKitFactory.stackView(axis: .vertical)
        }()

        private lazy var lblTitle: UILabel = {
            UIKitFactory.label(style: .title)
        }()

        private lazy var lblErrorMessage: UILabel = {
            return UIKitFactory.label(style: .error)
        }()

        private lazy var btnLogin: UIButton = {
            let button = UIKitFactory.raisedButton(title: Messages.login.localised)
            return button
        }()

        private lazy var txtPassword: SkyFloatingLabelTextField = {
            let some = UIKitFactory.skyFloatingLabelTextField(title: Messages.password.localised,
                                                              placeholder: "Your \(Messages.password.localised)")
            some.isSecureTextEntry = true
            some.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            return some
        }()

        private lazy var txtUserName: SkyFloatingLabelTextField = {
            let some = UIKitFactory.skyFloatingLabelTextField(title: Messages.email.localised,
                                                              placeholder: "Your \(Messages.email.localised)")
            some.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            return some
        }()

        // MARK: - Mandatory

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 1/3 : JUST to add stuff to the view....
        public override func prepareLayoutCreateHierarchy() {
            addSubview(scrollView)
            scrollView.addSubview(stackViewVLevel1)
            stackViewVLevel1.uiUtils.addArrangedSeparator(withSize: screenHeight/5)
            stackViewVLevel1.uiUtils.safeAddArrangedSubview(txtUserName)
            stackViewVLevel1.uiUtils.addArrangedSeparator()
            stackViewVLevel1.uiUtils.addArrangedSeparator()
            stackViewVLevel1.uiUtils.safeAddArrangedSubview(txtPassword)
            stackViewVLevel1.uiUtils.addArrangedSeparator()
            stackViewVLevel1.uiUtils.safeAddArrangedSubview(lblErrorMessage)
            addSubview(btnLogin)
        }

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 2/3 : JUST to setup layout rules zone....
        public override func prepareLayoutBySettingAutoLayoutsRules() {

            let margin = AppSizes.Margins.defaultMargin
            stackViewVLevel1.uiUtils.edgeStackViewToSuperView()
            scrollView.autoLayout.edgesToSuperview(excluding: .bottom, insets: .zero)
            scrollView.autoLayout.height(screenHeight)

            self.subViewsOf(types: [.button, .label], recursive: true).forEach { (some) in
                some.autoLayout.height(Designables.Sizes.Button.defaultSize.height)
                some.autoLayout.marginToSuperVerticalStackView(trailing: margin,
                                                               leading: margin)
            }

            btnLogin.autoLayout.centerXToSuperview()
            btnLogin.autoLayout.centerYToSuperview()
            btnLogin.autoLayout.leadingToSuperview(offset: margin)
            btnLogin.autoLayout.trailingToSuperview(offset: margin)
            btnLogin.autoLayout.height(Designables.Sizes.Button.defaultSize.height)

        }

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 3/3 : Stuff that is not included in [prepareLayoutCreateHierarchy] and [prepareLayoutBySettingAutoLayoutsRules]
        public override func prepareLayoutByFinishingPrepareLayout() {
            self.subViewsOf(types: [.label], recursive: true).forEach { (some) in
                (some as? UILabel)?.textAlignment = .center
            }
            setupLottie()
        }

        public override func setupColorsAndStyles() {
            self.backgroundColor = ComponentColor.background
        }

        // This function is called automatically by super BaseGenericView
        public override func setupViewUIRx() {

        }

        // This will notify us when something has changed on the textfield
        @objc func textFieldDidChange(_ textfield: UITextField) {

        }

        func setupLottie() {
            // https://lottiefiles.com/blog/working-with-lottie/how-to-add-lottie-animation-ios-app-swift
            animationView = AnimationView(name: "23038-animatonblue")
            addSubview(animationView)
            animationView.autoLayout.width(200)
            animationView.autoLayout.height(200)
            animationView.autoLayout.topToBottom(of: btnLogin)
            animationView.autoLayout.centerXToSuperview()
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.animationSpeed = 0.5
            stackViewVLevel1.uiUtils.safeAddArrangedSubview(lblErrorMessage)
            animationView.play()
            //DevTools.DebugView.paint(view: animationView)
        }

        // MARK: - Custom Getter/Setters

        func setupWith(screenState viewModel: VM.CarTrackLogin.ScreenState.ViewModel) {
            screenLayout = viewModel.layout
        }

        func setupWith(screenInitialState viewModel: VM.CarTrackLogin.ScreenInitialState.ViewModel) {
            lblTitle.textAnimated = viewModel.title
            txtUserName.text = viewModel.userName
            txtPassword.text = viewModel.password
            screenLayout = viewModel.screenLayout
        }

        private func userCanProceed(_ value: Bool) {
            if value {
                btnLogin.enable()
            } else {
                btnLogin.disable()
            }
        }
        func setupWith(nextButtonState viewModel: VM.CarTrackLogin.NextButtonState.ViewModel) {
            userCanProceed(viewModel.isEnabled)
        }

        var screenLayout: CarTrackLoginView.ScreenLayout = .enterUserCredentials {
            didSet {
                func setErrorMessage(_ message: String, forField: SkyFloatingLabelTextField) {
                    forField.errorMessage = message
                }
                setErrorMessage("", forField: txtUserName)
                lblErrorMessage.alpha = 0
                lblErrorMessage.text = ""
                switch screenLayout {
                case .enterUserCredentials:
                    userCanProceed(false)
                    setErrorMessage("", forField: txtPassword)
                    setErrorMessage("", forField: txtUserName)
                case .wrongUserCredencial(errorMessage: let errorMessage):
                    lblErrorMessage.textAnimated = errorMessage
                    lblErrorMessage.fadeTo(1)
                case .invalidEmailFormat(errorMessage: let errorMessage):
                    setErrorMessage(errorMessage, forField: txtUserName)
                    setErrorMessage("", forField: txtPassword)
                case .invalidPasswordFormat(errorMessage: let errorMessage):
                    setErrorMessage(errorMessage, forField: txtPassword)
                    setErrorMessage("", forField: txtUserName)
                case .invalidEmailFormatAndPasswordFormat(passwordErrorMessage: let passwordErrorMessage, emailErrorMessage: let emailErrorMessage):
                    setErrorMessage(emailErrorMessage, forField: txtUserName)
                    setErrorMessage(passwordErrorMessage, forField: txtPassword)
                case .enterPassword:
                    txtPassword.becomeFirstResponder()
                case .allFieldsAreValid:
                    setErrorMessage("", forField: txtPassword)
                    setErrorMessage("", forField: txtPassword)
                    lblErrorMessage.fadeTo(0)
                }
            }
        }
    }
}

// MARK: - Events capture

extension V.CarTrackLoginView {
    var rxBtnLoginTap: Observable<Void> { btnLogin.rx.tapSmart(disposeBag) }
    var rxTxtPassword: Reactive<SkyFloatingLabelTextField> { txtPassword.rx }
    var rxTxtUsername: Reactive<SkyFloatingLabelTextField> { txtUserName.rx }
    var txtUsernameIsFirstResponder: Bool { txtUserName.isFirstResponder }
    var txtPasswordIsFirstResponder: Bool { txtPassword.isFirstResponder }
}
