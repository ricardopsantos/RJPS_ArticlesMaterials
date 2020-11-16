//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RxSwift
import RxCocoa
import RxGesture
//
import BaseUI
import BaseConstants
import DevTools
import PointFreeFunctions
import AppTheme

open class TopBar: BaseViewControllerVIP {

    deinit {
        DevTools.Log.logDeInit("\(self.className) was killed")
        NotificationCenter.default.removeObserver(self)
    }

    private var btnSize: CGFloat { return TopBar.defaultHeight(usingSafeArea: true) / 2.0 }
    private var baseViewControllerTitle: String = ""
    private var usingSafeArea: Bool = false

    private lazy var btnBack: UIButton = {
        let some = UIKitFactory.button(baseView: self.view, style: .notApplied)
        some.rjsALayouts.setMargin(btnSize/2, on: .left)
        some.rjsALayouts.setMargin(btnSize/2, on: .top)
        some.rjsALayouts.setSize(CGSize(width: btnSize, height: btnSize))
        some.setTitleForAllStates("<")
        some.isHidden = true
        some.isUserInteractionEnabled = false
        return some
    }()

    private lazy var btnClose: UIButton = {
        let some = UIKitFactory.raisedButton(title: "X")
        self.view.addSubview(some)
        some.rjsALayouts.setMargin(btnSize/2, on: .right)
        some.rjsALayouts.setMargin(btnSize/2, on: .top)
        some.rjsALayouts.setSize(CGSize(width: btnSize, height: btnSize))
        some.setTitleForAllStates("X")
        some.addCorner(radius: 5)
        some.backgroundColor = ComponentColor.onPrimary.withAlphaComponent(FadeType.regular.rawValue)
        some.titleLabel?.textColor = ComponentColor.primary
        some.setTitleColor(ComponentColor.primary, for: .normal)
        some.isHidden = true
        some.isUserInteractionEnabled = false
        return some
    }()

    private lazy var lblTitle: UILabelWithPadding = {
        let some = UIKitFactory.labelWithPadding(style: .navigationBarTitle)
        self.view.addSubview(some)
        some.textAlignment = .center
        some.rjsALayouts.setMargin(btnSize*2, on: .left)
        some.rjsALayouts.setMargin(btnSize*2, on: .right)
        some.rjsALayouts.setMargin(0, on: .top)
        some.rjsALayouts.setMargin(0, on: .bottom)
        some.numberOfLines = 0
        return some
    }()

    public override func loadView() {
        super.loadView()
        view.accessibilityIdentifier = self.genericAccessibilityIdentifier
    }

    open override func prepareLayoutCreateHierarchy() {
        super.prepareLayoutCreateHierarchy()
        btnBack.lazyLoad()
        btnClose.lazyLoad()
        lblTitle.lazyLoad()
    }

    open override func prepareLayoutBySettingAutoLayoutsRules() {
        super.prepareLayoutBySettingAutoLayoutsRules()
    }

    open override func prepareLayoutByFinishingPrepareLayout() {
        super.prepareLayoutByFinishingPrepareLayout()
        self.view.backgroundColor    = TopBar.defaultColor
        if lblTitle.text.isEmpty && !baseViewControllerTitle.isEmpty {
            lblTitle.textAnimated = baseViewControllerTitle
        }
    }

}

//
// MARK: - Public
//

public extension TopBar {
    var height: CGFloat { return TopBar.defaultHeight(usingSafeArea: self.usingSafeArea ) }
    static var defaultColor: UIColor { ComponentColor.TopBar.background }
    static func defaultHeight(usingSafeArea: Bool) -> CGFloat {
        // [usingSafeArea=false] will make the TopBar go up and use space on the safe area
        return 60 + (!usingSafeArea ? AppleSizes.safeAreaTop : 0)
    }
    func addBackButton() { enable(btn: btnBack) }
    func addDismissButton() { enable(btn: btnClose) }
    func setTitle(_ title: String) { lblTitle.textAnimated = title }

    var rxSignal_btnDismissTapped: Signal<Void> {
        return btnClose.rx.controlEvent(.touchUpInside).asSignal()
    }
    
    var rxSignal_btnBackTapped: Signal<Void> {
        return btnBack.rx.controlEvent(.touchUpInside).asSignal()
    }
    
    var rxSignal_viewTapped: Signal<CGPoint> {
        return lblTitle.rx
            .tapGesture()
            .when(.recognized)
            .map({ $0.location(in: $0.view)})
            .asSignal(onErrorJustReturn: .zero)
    }

    // [usingSafeArea=false] will make the TopBar go up and use space on the safe area
    func injectOn(viewController: UIViewController, usingSafeArea: Bool = false) {
        self.baseViewControllerTitle = viewController.title ?? ""
        self.usingSafeArea = usingSafeArea
        let container  = UIView()
        viewController.view.addSubview(container)
        UIViewController.loadViewControllerInContainedView(sender: viewController,
                                                               senderContainedView: container,
                                                               controller: self) { (_, _) in }

        container.autoLayout.trailingToSuperview()
        container.autoLayout.leftToSuperview()
        container.autoLayout.topToSuperview(usingSafeArea: usingSafeArea)
        container.autoLayout.height(TopBar.defaultHeight(usingSafeArea: usingSafeArea))
        self.view.edgesToSuperview()
    }
}

// MARK: - Private

private extension TopBar {
    func enable(btn: UIButton) {
        btn.isHidden                 = false
        btn.isUserInteractionEnabled = true
    }
}
