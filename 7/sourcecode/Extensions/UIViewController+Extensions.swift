//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RxCocoa
import RxSwift
//
import DevTools

public extension UIViewController {

    var genericAccessibilityIdentifier: String {
        // One day we will have Accessibility on the app, and we will be ready....
        let name = String(describing: type(of: self))
        return "accessibilityIdentifierPrefix.\(name)"
    }

    func debugStack() {
        if let navigationController = self.navigationController {
            if navigationController.children.count > 0 {
                DevTools.Log.message("Children's : \(navigationController.children.count)")
                DevTools.Log.message("Fist Nav : \(String(describing: navigationController.children.first?.className))")
                var childrensInfo = ""
                navigationController.children.forEach { (some) in
                    childrensInfo += " -\(some.className)\n"
                }
                DevTools.Log.message("Children\n \(childrensInfo)")
            }
        }
    }
}
