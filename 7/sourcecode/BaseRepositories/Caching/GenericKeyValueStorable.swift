//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

// swiftlint:disable rule_Coding

import Foundation

// The objective of this class is to provide a way of storing (anywhere) some entity that is only available a certain amount of time (till `expireDate`)
// Its useful for caching of store temporary data

public class GenericKeyValueStorable: Codable {
    public var keyBase: String = ""
    public var key: String = ""         // Computed cache key (with parameters)
    public var keyParams: String = ""   // Only the parameters used on building the key
    private var object: String = ""     // Value to be stored
    public var valueType: String = ""
    public var recordDate: Date = GenericKeyValueStorable.referenceDate
    public var expireDate: Date = GenericKeyValueStorable.referenceDate
    public var encoding: Int = ValueEncoding.base64.rawValue
    public var objectType: String = ""

    public convenience init(composedKey: String,
                            keyBase: String,
                            keyParams: String,
                            value: String,
                            timeToLive: Int, // minutes
                            valueType: String,
                            encoding: ValueEncoding,
                            objectType: String) {
        self.init()
        self.key       = composedKey
        self.keyBase   = keyBase
        self.keyParams = keyParams
        self.object    = value
        self.recordDate = GenericKeyValueStorable.referenceDate
        self.expireDate = GenericKeyValueStorable.referenceDate.addingTimeInterval(TimeInterval(timeToLive*60))
        self.encoding   = encoding.rawValue
        self.valueType  = valueType
        self.objectType = objectType
    }

    public enum ValueEncoding: Int {
        case plainJSON = 0
        case base64
        case data
    }

    static var referenceDate: Date {
        return Date()
    }

    public var objectResume: String {
        return ("\(key) | \(objectType) | \(expireDate)")
    }

    public var toData: Data? {
        if let data = try? JSONEncoder().encode(self) {
            return data
        }
        return nil
    }

    public var value: String? {
        if Self.referenceDate < self.expireDate {
            return object
        } else {
            return nil
        }
    }
}

extension GenericKeyValueStorable {

    public convenience init<T: Codable>(_ some: T, key: String, params: [String] = [], lifeSpam: Int = 5) {
        self.init()
        var valueType = ""
        var value = ""
        if let toStore = try? JSONEncoder().encode(some) {
            value = String(decoding: toStore, as: UTF8.self)
            valueType = "\(String(describing: type(of: some)))"
        }
        self.key        = CacheUtils.composedKey(key, params)
        self.keyBase    = key
        self.keyParams  = CacheUtils.parseKeyParams(params)
        self.object     = value
        self.recordDate = GenericKeyValueStorable.referenceDate
        self.expireDate = GenericKeyValueStorable.referenceDate.addingTimeInterval(TimeInterval(lifeSpam*60))
        self.encoding   = ValueEncoding.data.rawValue
        self.valueType  = valueType
        self.objectType = "\(T.Type.self)"
    }

}
