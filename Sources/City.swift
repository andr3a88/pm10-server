//
//  City.swift
//  pm10-server
//
//  Created by Andrea on 29/10/2017.
//

import PerfectLib
import Foundation

class City: JSONConvertibleObject {

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
    
    override init () {
    }
    
    init(name: String, levels: [Level]) {
        self.name = name
        self.levels = levels
    }
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.name = getJSONValue(named: "name", from: values, defaultValue: "")
        self.levels = getJSONValue(named: "levels", from: values, defaultValue: [])
    }
    
    override public func getJSONValues() -> [String : Any] {
        return [
            "name": name,
            "levels": levels,
            "today_level": todayLevel
        ]
    }
}

