//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class DIAssemblerScenesGalleryApp {
    class var assembler: Assembler {
        let assemblyList: [Assembly] = [DIAssemblyContainerGalleryApp()]
        return Assembler(assemblyList)
    }
}
