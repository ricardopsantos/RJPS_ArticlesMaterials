//
//  Created by Santos, Ricardo Patricio dos on 15/01/2023.
//

import Foundation

public struct RequestDto {
   private init() { }
}

public extension RequestDto {
    struct Employee {
        public let someParam: String
        public init(someParam: String) {
            self.someParam = someParam
        }
    }
}
