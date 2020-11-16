//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import BaseConstants

public protocol BaseViewProtocol: AnyObject {
    func displayMessage(_ message: String, type: AlertType)
}
