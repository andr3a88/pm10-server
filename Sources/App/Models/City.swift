//
//  City.swift
//  App
//
//  Created by Andrea Stevanato on 16/07/2018.
//

import Foundation
import Vapor

struct City: Content {

    // MARK: Properties

    var name: String = ""
    var levels: [Level] = []

    var todayLevel: Int {
        var currentLevel = -1
        for level in levels where NSCalendar.current.isDateInToday(Date(timeIntervalSince1970: level.day)) == true {
            currentLevel = level.value
        }
        return currentLevel
    }

    // MARK: Methods
    init() {
    }


    init(name: String, levels: [Level]) {
        self.name = name
        self.levels = levels
    }

    static func stubbed() -> [City] {
        return [ City(name: "Spinea", levels: [Level(day: 0, value: 1), Level(day: 1, value: 2)]),
                 City(name: "Martellago", levels: [Level(day: 0, value: 1), Level(day: 1, value: 2)])
        ]

    }
}
