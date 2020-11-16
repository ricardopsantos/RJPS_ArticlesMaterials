//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import Pulsator

public extension UIView {
    func lazyLoad() { /* Lazy loading aux */ }

    func addPulse() {
        let pulsator = Pulsator()
        pulsator.numPulse = 1
        self.layer.addSublayer(pulsator)
        pulsator.start()
    }
}
