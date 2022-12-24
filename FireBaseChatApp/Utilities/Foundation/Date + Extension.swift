//
//  Date + Extension.swift
//  kotinethin
//
//

import Foundation

extension Date {
    
    func getDaysInMonth() -> Int {
        let calendar = Calendar.current
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        if let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        
        return 30
    }
    
    func getCurrentMonth() -> Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    func getCurrentDay() -> Int {
        return Calendar.current.component(Calendar.Component.day, from: self)
    }
    
    func getCurrentYear() -> Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    func getCurrentHour() -> Int {
        return Calendar.current.component(Calendar.Component.hour, from: self)
    }
    
    func getCurrentMinute() -> Int {
        return Calendar.current.component(Calendar.Component.minute, from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) ?? Date()
    }
    
    func nextDay(increase: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 0, day: increase), to: self) ?? Date()
    }
    
    func nextDay() -> Date {
        return nextDay(increase: 1)
    }
    
    func previousDay(decrease: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 0, day: -(decrease)), to: self) ?? Date()
    }
    
    func weekDayString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("EEEE")
        return df.string(from: self)
    }
    
    func lastWeek() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 0, day: -7), to: self) ?? Date()
    }
    
    func lastMonth(decrease: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: -(decrease), day: 0), to: self) ?? Date()
    }
    
    func getCurrentDate() -> Date {
        return Date.from(year: self.getCurrentYear(), month: self.getCurrentMonth(), day: self.getCurrentDay())
    }
    
    func getCurrentMilliSec() -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        
        formatter.timeStyle = .medium
        
        formatter.timeZone = TimeZone.current
        
        let current = formatter.string(from: self)
        let stringCurrent = formatter.date(from: current)
        
        let inMillis = stringCurrent!.timeIntervalSince1970
        return "\(Int(inMillis))"
    }
    
    static func from(year: Int, month: Int, day: Int, hour: Int = Date().getCurrentHour(), minute: Int = Date().getCurrentMinute()) -> Date {
        
        let currentDate = Date()
        
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian) else { return currentDate }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.timeZone = TimeZone.current
        
        let date = gregorianCalendar.date(from: dateComponents) ?? currentDate
        return date
    }
    
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
    
    func getImageFileName() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd HHmmss"
        return df.string(from: self)
    }
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var dayMonthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var yyyyMMtoString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var ddMMyyyytoString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var to12HrTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var to24HrTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var toDateAndTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}
