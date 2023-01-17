//
//  Created by Santos, Ricardo Patricio dos on 15/01/2023.
//

import Foundation

//
// MARK: - ExpiringCodableObjectWithKey
//

class ExpiringCodableObjectWithKey: Codable {
    public private (set) var key: String!       // Cache key (built using api request name and parameters)
    public private (set) var object: Data?      // Value to be stored
    public private (set) var expireDate: Date!  // The limit date in witch we can retried the object
    public private (set) var recordDate: Date!
    public private (set) var objectType: String!  // Value type to be stored (not needed for now)

    public convenience init(key: String,
                            expireDate: Date,
                            object: Data?,
                            objectType: String) {
        self.init()
        self.key        = key
        self.recordDate = Self.referenceDate
        self.expireDate = expireDate
        self.objectType = objectType
        self.object     = object
    }
    
    public convenience init(key: String,
                            params: [String],
                            object: Data?,
                            timeToLiveMinutes: Int? = nil) {
        self.init(key: ExpiringCodableObjectWithKey.composedKey(key, params),
                  expireDate: Self.ttlUsing(base: Self.referenceDate, with: timeToLiveMinutes ?? Self.defaultMinutesTTL),
                  object: object,
                  objectType: "\(String(describing: type(of: object)))")
    }
    
    public convenience init<T: Codable>(_ codable: T,
                                        key: String,
                                        params: [String] = [],
                                        timeToLiveMinutes: Int? = nil) {
        self.init(key: ExpiringCodableObjectWithKey.composedKey(key, params),
                  expireDate: Self.ttlUsing(base: Self.referenceDate, with: timeToLiveMinutes ?? Self.defaultMinutesTTL),
                  object: try? JSONEncoder().encode(codable),
                  objectType: "\(String(describing: type(of: codable)))")
    }
    
}

//
// MARK: - fileprivate
//

fileprivate extension ExpiringCodableObjectWithKey {
    var toData: Data? { try? JSONEncoder().encode(self) }
    static var referenceDate: Date { Date.utcNow }
    static var defaultMinutesTTL: Int { 60 * 24 }
    static func ttlUsing(base: Date, with ttl: Int?) -> Date {
        if let ttl = ttl {
            return base.add(minutes: ttl)
        } else {
            return base.add(minutes: defaultMinutesTTL)
        }
    }
}

//
// MARK: - Public
//

extension ExpiringCodableObjectWithKey {
    
    static func composedKey(_ key: String, _ keyParams: [String]) -> String {
        return "\(key)_[" + keyParams.joined(separator: ",") + "]"
    }
    
    var isExpired: Bool { valueData == nil }
    
    func extract<T: Codable>(_ some: T.Type) -> T? {
        guard let data = valueData else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    var valueData: Data? {
        guard Self.referenceDate < expireDate else {
            return nil
        }
        return object
    }
}

