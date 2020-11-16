//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    func subViewsOf(types: [UIKitViewFactoryElementTag], recursive: Bool) -> [UIView] {
        var acc: [UIView] = []
        types.forEach { (some) in
            acc.append(contentsOf: self.subViewsWith(tag: some.rawValue, recursive: recursive))
        }
        return acc
    }

    func subViewsOf(type: UIKitViewFactoryElementTag, recursive: Bool) -> [UIView] {
        return self.subViewsWith(tag: type.rawValue, recursive: recursive)
    }

    func subViewsWith(tag: Int, recursive: Bool) -> [UIView] {
        if recursive {
            return self.getAllSubviews().filter { $0.tag == tag }
        } else {
            return self.subviews.filter { $0.tag == tag }
        }
    }

    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        parenView.subviews.flatMap { subView -> [UIView] in
            var result = getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { UIView.getAllSubviews(from: self) as [T] }

    func get<T: UIView>(all type: T.Type) -> [T] { UIView.getAllSubviews(from: self) as [T] }

    func get(all types: [UIView.Type]) -> [UIView] { UIView.getAllSubviews(from: self, types: types) }

    func bringToFront() { superview?.bringSubviewToFront(self) }

    func sendToBack() { superview?.sendSubviewToBack(self) }
}
