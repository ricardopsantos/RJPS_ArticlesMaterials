//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import ToastSwiftFramework
import RxCocoa
import RxSwift
//
import RJSLibUFBase
import PointFreeFunctions

public struct DevTools {
    private init() { }

    private static var disposeBag = DisposeBag()
    public static var reachabilityService: ReachabilityService! = try! DefaultReachabilityService()

    private static var appMode: String? {
        (Bundle.main.infoDictionary?["BuildConfig_AppMode"] as? String)?.replacingOccurrences(of: "\\", with: "")
    }

    public static var isProductionApp = appMode == "Debug.Prod"
    public static var isQualityApp    = appMode == "Debug.QA"
    public static var isStagingApp    = appMode == "Debug.Dev"
    public static var isMockApp       = appMode == "Debug.Mock"

    public static var onRealDevice: Bool {
        return !onSimulator
    }

    public static var onSimulator: Bool { RJS_Utils.onSimulator }
    public static var onDebug: Bool { RJS_Utils.onDebug }
    public static var onRelease: Bool { RJS_Utils.onRelease }

    public static var isQualityReleaseApp: Bool {
        // Should return true, if is a Quality Team app
        return isQualityApp && onRelease
    }

    public static var isProductionReleaseApp: Bool {
        // Should return true, if is a Production app
        return isProductionApp && onRelease
    }

    public static var devModeIsEnabled: Bool {
        if isProductionReleaseApp {
            return false
        }
        return onDebug || onSimulator
     }

    public static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        return UIApplication.topViewController(base: controller)
    }
}

extension DevTools {
    public struct DebugView {
        public static func paint(view: UIView, enabled: Bool = true, method: Int = 1) {
            guard onSimulator else { return }
            guard enabled else { return }

            if method == 1 {
                view.layer.borderColor = UIColor.random.cgColor
                view.layer.borderWidth = 1
                view.devTools_getAllSubviews().forEach { (some) in
                    some.layer.borderColor = UIColor.random.cgColor
                    some.layer.borderWidth = 1
                }
            } else {
                view.backgroundColor = UIColor.random
                view.devTools_getAllSubviews().forEach { (some) in
                    some.backgroundColor = UIColor.random.withAlphaComponent(0.3)
                    some.alpha = 0.6
                }
            }
        }
    }
}

public extension DevTools {

        // A improved approach for things like "assert(key != nil, "Could not obtain public key")"
    // Better that (Foundation) assert because :
    //  1 - if 'forceFix==true', crashes the app to force the fix
    //  2 - on the console log (Swift.print), tells where the fail was exactly and therefore is easier to find and fix
    //  3 - we can add safe guards depending on app env.
    static func assert(_ isTrue:@autoclosure() -> Bool,
                       message: String="",
                       function: StaticString = #function,
                       file: StaticString = #file,
                       line: Int = #line,
                       forceFix: Bool=false) {
        guard onSimulator || onDebug else {
            return
        }

        if !isTrue() {
            let messageFinal = "\(message)\n\n@\(whereAmIDynamic(function: "\(function)", file: "\(file)", line: line, short: true))"
            DevTools.makeToast(messageFinal, isError: true)
            // swiftlint:disable no_print
            print("⛔⛔⛔⛔⛔ assert ⛔⛔⛔⛔⛔")
            print("⛔⛔⛔⛔⛔ assert ⛔⛔⛔⛔⛔")
            // swiftlint:enable no_print
            print(messageFinal)
            if forceFix {
                fatalError("\nThis need to be fixed now!\n")
            }
        }
    }
    /// if [searchForErrors] = true, the message will be scaned in order to decide if its an error and should present a different toast specific for error
    static func makeToast(_ message: String, isError: Bool = false, function: String = #function, file: String = #file, line: Int = #line, duration: TimeInterval? = nil) {
        guard !DevTools.isProductionReleaseApp else { return } //If production bail out immediately
        guard DevTools.devModeIsEnabled else { return } // Not dev mode? bail out immediately
        if isError {
            guard DevTools.FeatureFlag.showToastsOnErrors.isTrue else { return }
        }

        // Delay because sometimes we are changing screen, and the toast would be lost..
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var style = ToastStyle()
            style.cornerRadius = 5

            let messageFinal = "\(message)\n\n@\(whereAmIDynamic(function: "\(function)", file: "\(file)", line: line, short: true))"
            if isError {
                style.backgroundColor = UIColor.red.withAlphaComponent(0.9)
                style.messageColor = .white
                let duration: TimeInterval = (duration != nil) ? duration! : 10.0
                DevTools.topViewController()?.view.makeToast(messageFinal, duration: duration, position: .top, style: style)
            } else {
                var style = ToastStyle()
                style.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
                style.messageColor = .white
                let duration: TimeInterval = (duration != nil) ? duration! : 3.0
                DevTools.topViewController()?.view.makeToast(messageFinal, duration: duration, position: .top, style: style)
            }
        }
    }
}

fileprivate extension UIView {

    class func devTools_getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = devTools_getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func devTools_getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        return parenView.subviews.flatMap { subView -> [UIView] in
            var result = devTools_getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func devTools_getAllSubviews<T: UIView>() -> [T] { return UIView.devTools_getAllSubviews(from: self) as [T] }
    func devTools_get<T: UIView>(all type: T.Type) -> [T] { return UIView.devTools_getAllSubviews(from: self) as [T] }
    func devTools_get(all types: [UIView.Type]) -> [UIView] { return UIView.devTools_getAllSubviews(from: self, types: types) }
}

extension DevTools {

    struct Install {
        private init() { }

        static func debugViewUI(on view: UIView) {
            guard !DevTools.isProductionReleaseApp else { return } // If production bail out immediately
            guard DevTools.devModeIsEnabled else { return }        // Not dev mode? bail out immediately

            let tapGesture = createTapGesture()
            tapGesture.numberOfTouchesRequired = 2
            view.addGestureRecognizer(tapGesture)
            tapGesture.rx.event.bind(onNext: { _ in
                DevTools.DebugView.paint(view: view, method: 1)
            }).disposed(by: disposeBag)
        }

        private static let numberOfTapsRequired = 3

        private static func createTapGesture() -> UITapGestureRecognizer {
            let tapGesture = UITapGestureRecognizer()
            tapGesture.numberOfTapsRequired = numberOfTapsRequired
            return tapGesture
        }

        private static func debugViewController(on view: UIView?) {
            guard !DevTools.isProductionReleaseApp else { return } //If production bail out immediately
            guard DevTools.devModeIsEnabled else { return } // Not dev mode? bail out immediately

            let tapGesture = createTapGesture()
            tapGesture.numberOfTouchesRequired = 1
            view?.addGestureRecognizer(tapGesture)
            tapGesture.rx.event.bind(onNext: { _ in
                DevTools.launchDebugViewController()
            }).disposed(by: disposeBag)
        }
    }

    static func launchDebugViewController() {
        fatalError("not implemented")
      //  let controller = VC.DebugScreenViewController(presentationStyle: .regularVC).embeddedInNavigationController()
      //  AppRouter.shared.topViewController()?.present(controller, animated: true) { }
    }

}
