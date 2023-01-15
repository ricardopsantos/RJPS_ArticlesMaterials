//
//  Created by Ricardo Santos on 11/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine

//
// MARK: - CodableCacheManagerProtocol
//

public protocol CodableCacheManagerProtocol {
    func syncStore<T: Codable>(_ codable: T, key: String, params: [String], timeToLiveMinutes: Int?)
    func syncRetrieve<T: Codable>(_ type: T.Type, key: String, params: [String]) -> (model: T, recordDate: Date)?
}

//
// MARK: - SimpleCacheManagerForCodable
//

public class SimpleCacheManagerForCodable: CodableCacheManagerProtocol {
    private init() {}
    public static let shared = SimpleCacheManagerForCodable()

    public func syncStore<T: Codable>(_ codable: T,
                                      key: String,
                                      params: [String],
                                      timeToLiveMinutes: Int? = nil) {
        let expiringCodableObjectWithKey = ExpiringCodableObjectWithKey(codable,
                                                  key: key,
                                                  params: params,
                                                  timeToLiveMinutes: timeToLiveMinutes)
        UserDefaults.standard.set(try? JSONEncoder().encode(expiringCodableObjectWithKey), forKey: expiringCodableObjectWithKey.key)
    }

    public func syncRetrieve<T: Codable>(_ type: T.Type, key: String, params: [String]) -> (model: T, recordDate: Date)? {
        guard let data = UserDefaults.standard.data(forKey: ExpiringCodableObjectWithKey.composedKey(key, params)),
              let expiringCodableObjectWithKey = try? JSONDecoder().decode(ExpiringCodableObjectWithKey.self, from: data),
              let cachedRecord = expiringCodableObjectWithKey.extract(type) else {
            return nil
        }
        return (cachedRecord, expiringCodableObjectWithKey.recordDate)
    }
}
