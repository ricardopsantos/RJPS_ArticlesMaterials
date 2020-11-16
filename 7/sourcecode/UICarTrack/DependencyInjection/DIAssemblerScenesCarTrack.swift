//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class DIAssemblerScenesCarTrack {
    class var assembler: Assembler {
        let assemblyList: [Assembly] = [DIAssemblyContainerCarTrack()]
        return Assembler(assemblyList)
    }
}
