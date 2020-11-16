//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit

public protocol GenericTableViewProtocol: class {
    func configure(cell: GenericTableViewCellProtocol, indexPath: IndexPath)
    func numberOfRows(_ section: Int) -> Int
    func didSelectRowAt(indexPath: IndexPath)
    func numberOfSections() -> Int
    func didSelect(object: Any)
}

public extension GenericTableViewProtocol {
    func numberOfRows(_ section: Int) -> Int { return 0 }
    func numberOfSections() -> Int { return 1 }
    func didSelect(object: Any) { }
    func didSelectRowAt(indexPath: IndexPath) { }
}
