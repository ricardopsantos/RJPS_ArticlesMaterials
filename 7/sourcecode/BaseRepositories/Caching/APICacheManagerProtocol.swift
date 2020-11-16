//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RxSwift

// swiftlint:disable rule_Coding

public protocol APICacheManagerProtocol {
    func save<T: Codable>(_ some: T, key: String, params: [String], lifeSpam: Int)
    func getSync<T: Codable>(key: String, params: [String], type: T.Type) -> T?
    func genericCacheObserver<T: Codable>(_ some: T.Type, cacheKey: String, keyParams: [String], apiObserver: Single<T>) -> Observable<T>
}
