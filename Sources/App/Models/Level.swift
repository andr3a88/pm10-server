//
//  Level.swift
//  App
//
//  Created by Andrea Stevanato on 16/07/2018.
//

import Foundation
import Vapor

struct Level: Content {

    var day: TimeInterval = 0
    var value: Int = -1
    var dayDate: Date = Date()

    init(day: Double, value: Int) {
        self.day = day
        self.value = value
        self.dayDate = Date(timeIntervalSince1970: day)
    }
}
