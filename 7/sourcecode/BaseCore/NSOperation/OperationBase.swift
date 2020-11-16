//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

open class OperationBase: Operation {
    private var _executing = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    public override var isExecuting: Bool { return _executing }
    private var _finished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    public override var isFinished: Bool { return _finished }
    public func executing(_ executing: Bool) { _executing = executing }
    public func finish(_ finished: Bool) { _finished = finished }
}
