//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

public enum UIKitViewFactoryElementTag: Int {
    // Simple
    case view = 1000
    case button
    case scrollView
    case stackView
    case imageView
    case textField
    case searchBar
    case label
    case tableView
    case `switch`
    case stackViewSpace

    // component
    case reachabilityView

    // Composed
    case switchWithCaption
    case genericTitleAndValue
}
