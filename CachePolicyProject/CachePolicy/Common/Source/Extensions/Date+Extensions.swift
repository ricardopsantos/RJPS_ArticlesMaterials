//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation

public extension TimeInterval {
    var hourMinuteSecondMS: String { String(format: "%d:%02d:%02d.%03d", hour, minute, second, millisecond) }
    var minuteSecondMS: String { String(format: "%d:%02d.%03d", minute, second, millisecond) }
    var hour: Int { Int((self/3600).truncatingRemainder(dividingBy: 3600)) }
    var minute: Int { Int((self/60).truncatingRemainder(dividingBy: 60)) }
    var second: Int { Int(truncatingRemainder(dividingBy: 60)) }
    var millisecond: Int64 { Int64((self*1000).truncatingRemainder(dividingBy: 1000)) }
}

public extension Date {
    
    static var userDate: Date { return Date() }
    static var utcNow: Date { return Date() }
    static var systemDate: Date { return Date() }
    
    init(string: String) {
        self = Date.with(string) ?? Date.utcNow
    }
    
    private static var defaultDateFormatter: DateFormatter {
        DateFormatter()
    }
    
    static func with(_ dateToParse: String, dateFormat: String="yyyy-MM-dd'T'HH:mm:ssXXX") -> Date? {
        guard dateToParse != "null" else { return nil }
        guard dateToParse != "nil" else { return nil }
        guard !dateToParse.trim.isEmpty else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat // http://userguide.icu-project.org/formatparse/datetime
        if let date = dateFormatter.date(from: dateToParse) { return date }
        if let date = dateToParse.dates?.first { return date }
        if let unixTimestamp = dateToParse.doubleValue, unixTimestamp > 0 { return Date(timeIntervalSince1970: unixTimestamp) }
        return nil
    }
    
    var timeStyleShort: String {
        let formatter = Self.defaultDateFormatter
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: self)
    }
    
    var timeStyleMedium: String {
        let formatter = Self.defaultDateFormatter
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        return formatter.string(from: self)
    }
    
    var dateMediumTimeShort: String {
        let formatter = Self.defaultDateFormatter
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
    var dateShortTimeShort: String {
        let formatter = Self.defaultDateFormatter
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    var dateStyleMedium: String {
        let formatter = Self.defaultDateFormatter
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
    var dateStyleShort: String {
        let formatter = Self.defaultDateFormatter
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    var isToday: Bool { day == Date.userDate.day && month == Date.userDate.month && year == Date.userDate.year }
    var isYesterday: Bool {
        let yesterday = Date.userDate.add(days: -1)
        return day == yesterday.day && month == yesterday.month && year == yesterday.year
    }
    
    var seconds: Int { ((Calendar.current as NSCalendar).components([.second], from: self).second)! }
    var minutes: Int { ((Calendar.current as NSCalendar).components([.minute], from: self).minute)! }
    var hours: Int { ((Calendar.current as NSCalendar).components([.hour], from: self).hour)! }
    var day: Int { ((Calendar.current as NSCalendar).components([.day], from: self).day)! }
    var month: Int { ((Calendar.current as NSCalendar).components([.month], from: self).month)! }
    var year: Int { ((Calendar.current as NSCalendar).components([.year], from: self).year)! }
    var weekDay: Int { ((Calendar.current as NSCalendar).components([.weekday], from: self).weekday)! }
    
    func add(days: Int) -> Date { add(hours: days * 24) }
    func add(hours: Int) -> Date { add(minutes: hours * 60) }
    func add(minutes: Int) -> Date { add(seconds: minutes * 60) }
    func add(seconds: Int) -> Date { NSCalendar.current.date(byAdding: .second, value: seconds, to: self)! }
    func add(month: Int) -> Date { NSCalendar.current.date(byAdding: .month, value: month, to: self)! }
    func add(years: Int) -> Date { NSCalendar.current.date(byAdding: .year, value: years, to: self)! }
    func set(hour: Int) -> Date {
        Calendar.current.date(bySettingHour: hour >= 24 ? 0 : hour,
                              minute: minutes,
                              second: seconds,
                              of: self)!
    }
    func set(minute: Int) -> Date {
        Calendar.current.date(bySettingHour: hours,
                              minute: minute >= 60 ? 0 : minute,
                              second: seconds,
                              of: self)!
    }
    func set(second: Int) -> Date {
        Calendar.current.date(bySettingHour: hours,
                              minute: minutes,
                              second: second >= 60 ? 0 : second,
                              of: self)!
    }
    
    func isBiggerThan(_ dateToCompare: Date) -> Bool {
        compare(dateToCompare) == ComparisonResult.orderedDescending
    }
    
    func wasLessThan(secondsAgo: Int) -> Bool {
        !isBiggerThan(Date().add(seconds: seconds))
    }
    
    func timeAgoString(resources: [String]=["sec ago", "min ago", "hrs ago", "days ago", "weeks ago"]) -> String {
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) \(resources[0])"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) \(resources[1])"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) \(resources[2])"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) \(resources[3])"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff) \(resources[4])"
    }
    
    /// Get next specific day of week.
    ///
    /// If you need to know what day it is next Sunday, just enter the day of the week.
    /// Weekday numbers to return specific day:
    /// Sunday = 1, Monday = 2, Tuesday = 3, Wednesday = 4, Thursday = 5, Friday = 6, Saturday = 7.
    /// - Warning: 0 or numbers greater than 7 will crash the app.
    func getNextSpecificDayOfWeek(_ weekday: Int,
                                  direction: Calendar.SearchDirection = .forward,
                                  considerToday: Bool = false) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(weekday: weekday)
        
        if considerToday && calendar.component(.weekday, from: self) == weekday { return self }
        return calendar.nextDate(after: self, matching: components, matchingPolicy: .nextTime, direction: direction)!
    }
}
