//
//  utils.swift
//  App
//
//  Created by Andrea Stevanato on 16/07/2018.
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
