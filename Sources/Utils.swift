//
//  Utils.swift
//  pm10-server
//
//  Created by Andrea on 28/10/2017.
//

import Foundation

struct Configuration {
    static let ArpavUrl = "http://www.arpa.veneto.it/inquinanti/bollettino_allerta_PM10.php"
    static let ArpavDateFormat = "dd/MM/yyyy"
}

struct Constants {
    static let DayTimeInterval: TimeInterval = 60*60*24
    static let HalfDayTimeInterval: TimeInterval = 60*60*12
}

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
