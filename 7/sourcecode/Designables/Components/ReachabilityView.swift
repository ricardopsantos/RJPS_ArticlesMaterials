//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RJSLibUFBase
import RJSLibUFALayouts
import RxSwift
import RxCocoa
//
import Factory
import AppResources
import BaseConstants
import AppTheme
import DevTools

open class ReachabilityView: UILabelWithPadding {

    var disposeBag = DisposeBag()
    var reachabilityService: ReachabilityService? = DevTools.reachabilityService // try! is only for simplicity sake

    public override var padding: UIEdgeInsets {
        let min: CGFloat = 0
        let top: CGFloat = RJS_DeviceInfo.hasNotch ? 0 + min : min
        return UIEdgeInsets(top: top, left: 5, bottom: 5, right: 5)
    }

    private var marginFromTop: CGFloat { return 0 }
    private var lblReachabilityDistanceFromTop: NSLayoutConstraint?
    static var defaultHeight: CGFloat = 25

    private func setVisibility(to: Bool) {
        RJS_Utils.executeInMainTread { [weak self] in
            guard let self = self else { return }
            let value = !to
            let duration = 0.5
            self.superview?.bringSubviewToFront(self)
            self.fadeTo(value ? 0 : FadeType.superLight.rawValue, duration: duration)
            self.rjsALayouts.updateConstraint(self.lblReachabilityDistanceFromTop!,
                                              toValue: value ? -ReachabilityView.self.defaultHeight : self.marginFromTop,
                                              duration: duration,
                                              completion: { (_) in

            })
        }
    }

    public func load() { }
    
    private func hide() {
        setVisibility(to: false)
    }

    private func show() {
        setVisibility(to: true)
    }

    private func setupReachabilityServiceRx() {
        reachabilityService?.reachability.subscribe(
            onNext: { [weak self] some in
                if some.reachable { self?.hide()
                } else { self?.show() }
            }
        ).disposed(by: disposeBag)
    }

    public static func injectOn(viewController: UIViewController) -> ReachabilityView {
        let tag = UIKitViewFactoryElementTag.reachabilityView
        if let reachabilityView = viewController.view.subViewsOf(type: tag, recursive: false).first as? ReachabilityView {
            // All-ready, lets return it....
            return reachabilityView
        }
        let some             = ReachabilityView()
        viewController.view.addSubview(some)
        some.tag             = tag.rawValue
        some.label.textColor = ComponentColor.TopBar.titleColor
        some.label.font      = AppFonts.Styles.caption.rawValue 
        some.textAlignment   = .center
        some.backgroundColor = ComponentColor.error.withAlphaComponent(FadeType.regular.rawValue)
        some.alpha           = 0
        some.text            = Messages.noInternet.localised
        some.rjsALayouts.setMargin(0, on: .left)
        some.rjsALayouts.setMargin(0, on: .right)
        some.lblReachabilityDistanceFromTop = some.rjsALayouts.setMargin(0, on: .top, method: .constraints)
        some.rjsALayouts.setHeight(ReachabilityView.defaultHeight)
        some.setupReachabilityServiceRx()
        return some
    }

}

public extension UIViewController {
    func addReachabilityView() -> ReachabilityView {
        return ReachabilityView.injectOn(viewController: self)
    }
}
