//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

// swiftlint:disable no_print rule_Coding

import Foundation
import UIKit
//
import RJSLibUFStorage

public var screenWidth: CGFloat { return UIScreen.main.bounds.width }
public var screenHeight: CGFloat { return UIScreen.main.bounds.height }

public func saveWith(key: String,
                     value: String,
                     expireDate: Date?=nil) {
    _ = RJS_StorableKeyValue.save(key: key, value: value, expireDate: expireDate)
}

public func getWith(key: String) -> String? {
    if let obj = RJS_StorableKeyValue.with(key: key) {
        return obj.value
    } else {
        return nil
    }
}

public func saveContext() {
    RJS_DataModelManager.saveContext()
}

public func synced<T>(_ lock: Any, closure: () -> T) -> T {
    objc_sync_enter(lock)
    let r = closure()
    objc_sync_exit(lock)
    return r
}

public func randomBool() -> Bool {
    return randomInt(min: 0, max: 1) == 0
}

public func randomInt(min: Int, max: Int) -> Int {
    return Int.random(in: min ..< max)
}

public func randomStringWith(length: Int, letters: String = "\n abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
    return String((0..<length).map { _ in letters.randomElement()! })
}

public func randomStringWith(prefix: String) -> String {
    return "\(prefix)\(randomStringWith(length: randomInt(min: 5, max: 10)))"
}

public func randomDate(d: Int?=nil, m: Int?=nil, y: Int?=nil) -> Date {
    let day = d != nil ? d! : randomInt(min: 1, max: 30)
    let mouth = m != nil ? m! : randomInt(min: 1, max: 12)
    let year = y != nil ? y! : randomInt(min: 2000, max: 2050)
    let calendar = Calendar.current
    var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
    dateComponents?.day = day
    dateComponents?.month = mouth
    dateComponents?.year = year
    if let dateComponentsUnwrapped = dateComponents,
        let date = calendar.date(from: dateComponentsUnwrapped) {
        return date
    }
    return Date()
}

public func whereAmIDynamic(function: String,
                            file: String,
                            line: Int,
                            short: Bool = false,
                            prefix: String = "") -> String {
    guard let fileName = "\(file)".components(separatedBy: "/").last else {
        return ""
    }
    if short {
        return "\(fileName) | \(function)"
    } else {
        if !prefix.isEmpty {
            return "\(prefix) | func [\(function)] in file [\(fileName)]"
        } else {
            return "L\(line), \(function) @ \(fileName)"
        }
    }
}

public func whereAmI(function: String = #function,
                     file: String = #file,
                     line: Int = #line,
                     short: Bool = false,
                     prefix: String = "") -> String {
    return whereAmIDynamic(function: function, file: file, line: line, short: short, prefix: prefix)
}

public func perfectMapper<A: Codable, B: Codable>(inValue: A, outValue: B.Type) -> B? {
    do {
        let encoded = try JSONEncoder().encode(inValue)
        let decoded = try JSONDecoder().decode(((B).self), from: encoded)
        return decoded
    } catch {
        let message = "# Conversion fail from [\(A.self)] to [\(B.self)]\n# In value [\(inValue)]\n# Error [\(error)]"
        printError(title: "perfectMapper", message: message)
        return nil
    }
}

extension String {
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}

private func printError(title: String, message: String) {
    #if DEBUG
        // swiftlint:disable no_print
        print("⛔⛔⛔⛔⛔ \(title) ⛔⛔⛔⛔⛔")
        print("⛔⛔⛔⛔⛔ \(title) ⛔⛔⛔⛔⛔")
        print(message)
        print("⛔⛔⛔⛔⛔ \(title) ⛔⛔⛔⛔⛔")
        print("⛔⛔⛔⛔⛔ \(title) ⛔⛔⛔⛔⛔")
        // swiftlint:enable no_print
    #endif
}

public func listFromCSV<T: Decodable>(_ dataString: String) -> [T] {
    do {
        guard let jsonKeys: [String] = dataString.components(separatedBy: "\n").first?.components(separatedBy: ",") else {
            printError(title: "Parsing Error", message: dataString)
            return []
        }
        var parsedCSV: [[String: String]] = dataString
            .components(separatedBy: "\n")
            .map({
                var result = [String: String]()
                for (index, value) in $0.components(separatedBy: ",").enumerated() {
                    if index < jsonKeys.count {
                        result["\(jsonKeys[index])"] = value
                    }
                }
                return result
            })
        parsedCSV.removeFirst()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parsedCSV, options: []) else {
            printError(title: "Parsing Error", message: "\(parsedCSV)")
            return []
        }
        return try JSONDecoder().decode([T].self, from: jsonData)
    } catch let error {
        printError(title: "Parsing Error", message: "\(error)")
    }
    return []
}
