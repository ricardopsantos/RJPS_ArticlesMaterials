//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: - Transformations / Operators
//

private extension String {
    private var cleanBeforeConversion: String {
        return replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    }
}

public extension String {

    var random: String { String.random(Int.random(in: 10...100)) }
    var length: Int { count }
    var first: String { String(prefix(1)) }
    var last: String { if count == 0 { return "" } else { return String(suffix(1))} }
    var trim: String { // Trim and single spaces
        return replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var onlyWhiteSpace: String { // String with only white spaces return ""
        return self.trimmingCharacters(in: .whitespaces) != "" ? self : ""
    }
    
    var multipleWhiteSpace: String { // String with more than one space return ""
        return replacingOccurrences(of: "  ", with: " ", options: .regularExpression)
    }
    var capitalised: String { count >= 1 ? prefix(1).uppercased() + lowercased().dropFirst() : "" }
    var encodedUrl: String? { addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) }
    var decodedUrl: String? { removingPercentEncoding }
    var reversed: String { var acc = ""; for char in self { acc = "\(char)\(acc)" }; return acc }

    var dateValue: Date? { Date.with(self) }
    var dates: [Date]? {
        var nsRange: NSRange { return NSRange(location: 0, length: length) }
        return try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue).matches(in: self, range: nsRange).compactMap { $0.date }
    }

    var isValidInt: Bool {
        // Only allow numbers. Look for anything not a number.
        let range = self.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted)
        return range == nil
    }
    
    var numberValue: NSNumber? { NumberFormatter().number(from: cleanBeforeConversion.replace(",", with: ".")) }
    var utf8Data: Data? { data(using: .utf8) }
    var boolValue: Bool? {
        if let some = cleanBeforeConversion.numberValue {
            return Bool(truncating: some)
        }
        return Bool((self as NSString).boolValue)
    }
    var intValue: Int? {
        if let some = cleanBeforeConversion.numberValue {
            return Int(truncating: some)
        }
        return Int((self as NSString).intValue)
    }
    var doubleValue: Double? {
        if let some = cleanBeforeConversion.numberValue {
            return Double(truncating: some)
        }
        return Double((self as NSString).doubleValue)
    }
    var cgFloatValue: CGFloat? {
        if let float = Float(self), float > 0 {
            return CGFloat(float)
        }
        if let some = cleanBeforeConversion.numberValue {
            return CGFloat(truncating: some)
        }
        return CGFloat((self as NSString).floatValue)
    }
    var floatValue: Float? {
        if let some = cleanBeforeConversion.numberValue {
            return Float(truncating: some)
        }
        return Float((self as NSString).floatValue)
    }
    var decimalValue: Decimal? {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let groupingSeparator = Locale.current.groupingSeparator ?? ","
        let regex: NSRegularExpression! = try? NSRegularExpression(pattern: "[^0-9\(decimalSeparator)]", options: .caseInsensitive)
        var formatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.decimalSeparator = decimalSeparator
            formatter.groupingSeparator = groupingSeparator
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }
        let regexedString = regex.stringByReplacingMatches(in: self,
                                                           options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                           range: NSRange(location: 0, length: count),
                                                           withTemplate: "")

        return formatter.number(from: regexedString)?.decimalValue
    }
}

//
// MARK: - Constructors
//

public extension String {
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}

//
// MARK: - Bools
//

public extension String {

    // Found at https://medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a
    var isValidEmail: Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    var isAlphanumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }

    var isOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }

    func contains(_ subString: String, ignoreCase: Bool=true) -> Bool {
        if ignoreCase {
            return lowercased().range(of: subString.lowercased()) != nil
        } else {
            return range(of: subString) != nil
        }
    }
}

//
// MARK: - Utils
//

public extension CustomStringConvertible where Self: Codable {
    var description: String {
        var description = "\n \(type(of: self)) \n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}

public extension String {

    func superscriptLastCharacter(font: UIFont) -> NSMutableAttributedString {
        let superscriptAtttributedString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        if let superscriptFont = UIFont(name: font.fontName, size: font.pointSize * 0.6) {
            superscriptAtttributedString.setAttributes(
                [
                    NSAttributedString.Key.font: superscriptFont,
                    NSAttributedString.Key.baselineOffset: font.lineHeight * 0.3
                ],
                range: NSRange(location: count - 1, length: 1)
            )
        }
        return superscriptAtttributedString
    }
    
    func dropFirstIf(_ some: String) -> String {
        if hasPrefix(some) {
            return "\(dropFirst(some.count))"
        } else {
            return self
        }
    }
    
    func dropLastIf(_ some: String) -> String {
        if hasSuffix(some) {
            return "\(dropLast(some.count))"
        } else {
            return self
        }
    }
    
    // let json = "{\"hello\": \"world\"}"
    // let dictFromJson = json.asDict
    var asDict: [String: Any]? {
        guard let data = data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }

    // let htmlString = "<p>Hello, <strong>world!</string></p>"
    // let attrString = htmlString.asAttributedString
    var asAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }

    func image(font: UIFont, size: CGSize = CGSize(width: 40, height: 40)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func split(by: String) -> [String] {
        guard !by.isEmpty else { return [] }
        return components(separatedBy: by)
    }

    static func random(_ length: Int, haveSpaces: Bool = false) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 0 ..< length {
            let rand = Int.random(in: 0...letters.length-1)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }

    static func randomWithSpaces(_ length: Int) -> String {
        let letters: NSString = " abcdef ghijklm nopqrst uvwxy zABCD EFGHI JKLMN OPQ RSTUV WXYZ01 2345 6789"
        var randomString = ""
        for _ in 0 ..< length {
            let rand = Int.random(in: 0...letters.length-1)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    func replace(_ some: String, with: String) -> String {
        guard !some.isEmpty else { return self }
        return replacingOccurrences(of: some, with: with)
    }

}

public extension String {
    /// _10 min_ -> _10_
    var extrateMinutes: Int {
        var minutes: Int = 0
        if self.contains(" "),
           let value = self.split(by: " ").first,
            let intValue = value.intValue, intValue > 0 {
            minutes = intValue
        } else if self.contains(" "),
           let value = self.split(by: " ").last,
            let intValue = value.intValue, intValue > 0 {
            minutes = intValue
        } else if let intValue = self.intValue, intValue > 0 {
            minutes = intValue
        }
        return minutes
    }
}

//
// MARK: - SubScript
//

public extension String {

    subscript (i: Int) -> String { return self[i ..< i + 1] }

    func substring(fromIndex: Int) -> String { return self[min(fromIndex, length) ..< length] }

    func substring(toIndex: Int) -> String { return self[0 ..< max(0, toIndex)] }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start..<end]
    }

    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start...end]
    }

    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        if end < start { return "" }
        return self[start...end]
    }

    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex...end]
    }

    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex..<end]
    }

}
