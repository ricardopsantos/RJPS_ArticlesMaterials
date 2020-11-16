//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import DevTools

public class OperationQueueManager {
    private init() {
        if operationQueue == nil {
            operationQueue = OperationQueue()
            operationQueue!.maxConcurrentOperationCount = 5
        }
    }
    private var operationQueue: OperationQueue?
    public static var shared = OperationQueueManager()

    public func add(_ operation: Operation) {
        guard let operationQueue = operationQueue else {
            return
        }
        if operationQueue.operations.count > 10 {
            DevTools.Log.warning("Too many operations: \(operationQueue.operations.count)")
        }
        operationQueue.addOperations([operation], waitUntilFinished: false)
    }
}
