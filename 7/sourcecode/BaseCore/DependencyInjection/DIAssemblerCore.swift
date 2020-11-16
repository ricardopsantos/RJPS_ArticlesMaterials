//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class DIAssemblerCore {
    class var assembler: Assembler {
        let assemblyList: [Assembly] = [DIAssemblyContainerCore()]
        return Assembler(assemblyList)
    }
}
