//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine

public typealias CancelBag = AutoReleasedCancelBag

/// CancelBag as Set
public final class AutoReleasedCancelBag {
    public var autoReleasedSubscriptions = [(AnyCancellable, String)]()
    public var nonAutoReleasedSubscriptions = Set<AnyCancellable>()

    public var hasSubcriptions: Bool {
        (autoReleasedSubscriptions.count + nonAutoReleasedSubscriptions.count) > 0
    }
    
    deinit {
        cancel()
    }
    
    public init() {
        autoReleasedSubscriptions = []
        nonAutoReleasedSubscriptions = Set<AnyCancellable>()
    }
    
    public func cancelFirst() {
        synced(autoReleasedSubscriptions) {
            autoReleasedSubscriptions.first?.0.cancel()
            autoReleasedSubscriptions.removeFirst()
        }
        synced(nonAutoReleasedSubscriptions) {
            nonAutoReleasedSubscriptions.first?.cancel()
            nonAutoReleasedSubscriptions.removeFirst()
        }
    }
    
    public func cancel() {
        synced(autoReleasedSubscriptions) {
            autoReleasedSubscriptions.forEach { $0.0.cancel() }
            autoReleasedSubscriptions.removeAll()
        }
        synced(nonAutoReleasedSubscriptions) {
            nonAutoReleasedSubscriptions.forEach { $0.cancel() }
            nonAutoReleasedSubscriptions.removeAll()
        }
    }
    
    @discardableResult
    public func removeWith(id: String) -> Bool {
        guard !id.trim.isEmpty else { return false }
        let exists = autoReleasedSubscriptions.map({ $0.1 }).contains(id)
        guard exists else { return false }
        let before = autoReleasedSubscriptions.count
        autoReleasedSubscriptions.filter({ $0.1 == id }).forEach {
            $0.0.cancel()
        }
        autoReleasedSubscriptions = autoReleasedSubscriptions.filter({ $0.1 != id })
        let after = autoReleasedSubscriptions.count
        return before > after
    }
}

public extension AnyCancellable {
    func store(in cancelBag: CancelBag,
               autoRelease: Bool = true,    /// Will cancel automaticly a previous subscription if there's allready a subscription with same id
               subscriptionId: String = "", /// subscription Id. If empty, the file, funtion and line will be used to calculate the subscription id
               file: String = #file,
               function: String = #function,
               line: Int = #line) {
        let fileName = "\(file.split(by: "/").last ?? "")"
        let computedID = !subscriptionId.trim.isEmpty ? subscriptionId.trim : "[\(fileName)|\(function)|\(line)]"
        if !autoRelease {
            cancelBag.nonAutoReleasedSubscriptions.insert(self)
        } else {
            synced(cancelBag.autoReleasedSubscriptions) {
                cancelBag.removeWith(id: computedID)
                cancelBag.autoReleasedSubscriptions.append((self, computedID))
            }
        }
    }
}

public final class DebounceCancelBag {
    public var subscriptions: [AnyCancellable] = []
    deinit {
        cancel()
    }
    public init() {
        subscriptions = []
    }
    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    public func cancelFirst() {
        subscriptions.first?.cancel()
        subscriptions.removeFirst()
    }
}

public extension AnyCancellable {
    func store(in cancelBag: DebounceCancelBag, id: String = "") {
        cancelBag.subscriptions.append(self)
        // Keep only 2 subcriptions:
        // 1 - One for the redraw button, 2 - and the debounce for the previous button (before redraw view)
        // See https://smarteurope.atlassian.net/browse/SAE-486
        if cancelBag.subscriptions.count >= 3 {
            cancelBag.cancelFirst()
        }
    }
}
