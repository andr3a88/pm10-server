//
//  Level.swift
//  pm10-server
//
//  Created by Andrea on 29/10/2017.
//

import PerfectLib
import Foundation

class Level : JSONConvertibleObject {

    var day: TimeInterval = 0
    var value: Int = -1
    
    init(day: Double, value: Int) {
        self.day = day
        self.value = value
    }
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.day = getJSONValue(named: "day", from: values, defaultValue: 0)
        self.value = getJSONValue(named: "value", from: values, defaultValue: -1)
    }
    
    override public func getJSONValues() -> [String : Any] {
        return [
            "day": day,
            "value": value
        ]
    }
}
