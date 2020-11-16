//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    enum LayoutStyle: CaseIterable {
        case notApplied
        case primary
        case secondary
        case secondaryDestructive
        case accept
        case reject
        case remind
        case inngage
    }
}

public extension UILabel {
    enum LayoutStyle: CaseIterable {
        case notApplied
        case navigationBarTitle
        case title
        case value
        case text
        case info
        case error
    }
}
