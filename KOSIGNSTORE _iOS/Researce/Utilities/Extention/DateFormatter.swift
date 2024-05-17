//
//  DateFormatter.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/9/24.
//

import Foundation

extension DateFormatter {
    
    func getRelativeDate(date: String) -> String {
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let data = checkFormatDate(data: date)
        let startDate = self.date(from: data)
        let endDate = NSDate() as Date
        let diff = checkDiffFromTimeZone(time: Int(endDate.timeIntervalSince1970 - startDate!.timeIntervalSince1970))
        let exampleDate = Date().addingTimeInterval(-Double(diff))
//        let locale = getLocaleIdentifier(lang: Share.language)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
//        formatter.locale = Locale(identifier: locale)
        let relativeDate = formatter.localizedString(for: exampleDate, relativeTo: Date())
        return relativeDate
    }
   
    
    
    
    func checkUpdateApp(data: AppDetailBody.VersionListInfo) -> Bool {
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dev = ""
        var real = ""
        var date = ""
        if data.dev != nil {
            dev = checkFormatDate(data: data.dev?.modifiedDate ?? "")
        }
        if data.real != nil {
            real = checkFormatDate(data: data.real?.modifiedDate ?? "")
        }
        
        if dev == "" && real == "" {
            return false
        }
        
        if dev == "" {
            date = real
        } else if real == "" {
            date = dev
        } else {
            if dev > real {
                date = dev
            } else {
                date = real
            }
        }
        let currentDate = Date()
        let fromDate    = self.date(from: date)
        let countDate   = Calendar.current.dateComponents([.day], from: fromDate!, to: currentDate).day!
        return countDate > 7 ? true : false
    }
    func checkFormatDate(data: String) -> String {
        if data.count > 19 {
            let mySubstring = data.prefix(19)
            return String(mySubstring)
        } else {
            return data
        }
    }
    func checkUpdate(data: AppDetailBody.VersionListInfo) -> Bool {
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = ""
        if let devModifiedDate = data.dev?.modifiedDate {
            date = checkFormatDate(data: devModifiedDate) ?? ""
        }
        
        if let realModifiedDate = data.real?.modifiedDate {
            let realDate = checkFormatDate(data: realModifiedDate) ?? ""
            
            if date.isEmpty || realDate > date {
                date = realDate
            }
        }
        if date.isEmpty {
            return false
        }
        let currentDate = Date()
        guard let fromDate = self.date(from: date) else {
            return false
        }
        let countDate = Calendar.current.dateComponents([.day], from: fromDate, to: currentDate).day ?? 0
        return countDate > 7
    }


    
    
    
    
    func checkDiffFromTimeZone(time: Int) -> Int {
        switch Shared.timeZone {
        case TZ.Cambodia.rawValue:
            return time
        case TZ.Korea.rawValue:
            return time - 7200
        default: return time
        }
    }
    
//    func getLocaleIdentifier(lang: LanguageCode) -> String {
//        switch lang {
//            
//        case .Korean:
//            return "ko-KR"
//        case .English:
//            return "en-US"
//        case .Khmer:
//            return "km-KH"
//        }
//    }
}
