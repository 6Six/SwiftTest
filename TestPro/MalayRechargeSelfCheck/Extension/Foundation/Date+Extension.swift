//
//  Date+Extension.swift
//  ep_wallet
//
//  Created by lt on 16/5/4.
//  Copyright © 2016年 cardsmart. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    var timestap: Double {
        return self.timeIntervalSince1970
    }
    
    static func dateFromTimestap(_ src: String) -> Date {
        if !src.isDigitalString {
            return Date(timeIntervalSince1970: 0)
        }
        
        var tmp = src
        if tmp.length > 10 {
            tmp = tmp.substringToIndex(10)
        }
        let date = Date(timeIntervalSince1970: Double(tmp)!)
        return date
    }
    
    func dayOfWeek() -> String {
        let weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        let interval = self.timeIntervalSince1970;
        let days = Int(interval / 86400);
        return weeks[(days - 3) % 7]
    }
    
    func dateAndWeek() -> String {
        let week = dayOfWeek()
        let day = dateToString(CSDateFormate.MonthDay)
        return day + " " + week
    }
    
    func timeAndWeek() -> String {
//        08-01 星期四 15:30
        let week = dayOfWeek()
        let day = dateToString(CSDateFormate.MonthDay)
        let time = dateToString(CSDateFormate.OnlyTime)
        return day + " " + week + " " + time
    }
    
    func dateToString(_ fm: CSDateFormate) -> String {
        APP.dateFormatter.dateFormat = fm.formate
        let rslt = APP.dateFormatter.string(from: self)
        return rslt
    }
    
    /**
     今天的开始时间 2015-03-02 00:00:00
     - returns: NSDate
     */
    static func startOfToday() -> Date {
        let calendar = Calendar.current.startOfDay(for: Date())
        return calendar
    }
    
    /**
     昨天的开始时间 2015-03-02 00:00:00
     - returns: NSDate
     */
    func startOfYesterday() -> Date {
        let yesterday = self.dateBeforeOneDay()
        let calendar = Calendar.current.startOfDay(for: yesterday)
        return calendar
    }
    
    /**
     昨天的结束时间 2015-03-02 23:59:59
     - returns: NSDate
     */
    static func endOfYesterdy() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return (Calendar.current as NSCalendar).date(byAdding: components, to: Date().startOfYesterday(), options: NSCalendar.Options())!
    }
    
    /**
     根据指定 日期的开始时间 获得 结束时间
     - returns: NSDate
     */
    static func dayEnd(_ date: Date) -> Date {
        
        // 得到当前的开始时间
        let startDate = Calendar.current.startOfDay(for: date)
        
        var components = DateComponents()
        components.day = 1
        components.second = -1 //
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startDate, options: NSCalendar.Options())!
    }
    
    func endOfMonth() -> Date{
        // 得到当前的开始时间
        let startDate = Calendar.current.startOfDay(for: self)
        
        var components = DateComponents()
        components.month = 1
        components.second = -1 //
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startDate, options: NSCalendar.Options())!
    }
    
    /**
     返回本月的第一天
     - returns: NSDate
     */
    func startOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        var beginDate: Date = Date()
        var interval: Double = 0
        let _ = calendar.dateInterval(of: Calendar.Component.month, start: &beginDate, interval: &interval, for: self)
        return beginDate
    }
    
    /**
     返回本周的第一天
     - returns: NSDate
     */
    func startOfWeek() -> Date {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        var beginDate: Date = Date()
        var interval: Double = 0
        let _ = calendar.dateInterval(of: Calendar.Component.weekOfMonth, start: &beginDate, interval: &interval, for: self)
        return beginDate
    }
    
    func dateBeforeOneDay() -> Date {
        return self.dateAfterDays(-1)
    }
    
    func dateBeforeOneMonth() -> Date {
        return self.dateAfterMonth(-1)
    }
    
    func dateBeforeThreeMonth() -> Date {
        return self.dateAfterMonth(-3)
    }
    
    func dateAfterMonth(_ month: Int) -> Date {
        let calendar = Calendar.current
        var comps = DateComponents()
        comps.month = month
        let date = (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options.matchStrictly)
        return date!
    }
    
    func dateAfterDays(_ days: Int) -> Date {
        let calendar = Calendar.current
        var comps = DateComponents()
        comps.day = days
        let date = (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options.matchStrictly)
        return date!
        
    }
    
    func hourFromDate() -> Int {
        let hour = (Calendar.current as NSCalendar).component(.hour, from: self)
        return hour
    }
    
    func dateAddingDays(_ day: Int) -> Date {
        return self.dateAddingHours(day * 24)
    }
    
    func dateAddingHours(_ hour: Int) -> Date {
        return self.dateAddingMinutes(hour * 60)
    }
    
    func dateAddingMinutes(_ minute: Int) -> Date {
        return self.dateAddingSecond(TimeInterval(minute * 60))
    }
    
    func dateAddingSecond(_ second: TimeInterval) -> Date {
        return self.addingTimeInterval(second)
    }
}
