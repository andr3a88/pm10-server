//
//  CityListResponse.swift
//  pm10-server
//
//  Created by Andrea on 30/10/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import PerfectLib
import Foundation

class CityListResponse: JSONConvertibleObject {

    // MARK: Properties
    
    var status: String = ""
    var error: String = ""
    var cities: [City] = []
    
    // MARK: Methods
    
    init(cities: [City]) {
        self.cities = cities
        self.status = "ok"
        self.error = ""
    }
    
    init(error: String) {
        self.cities = []
        self.status = "error"
        self.error = error
    }
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.status = getJSONValue(named: "status", from: values, defaultValue: "")
        self.cities = getJSONValue(named: "cities", from: values, defaultValue: [])
        self.error = getJSONValue(named: "error", from: values, defaultValue: "")
    }
    
    override public func getJSONValues() -> [String : Any] {
        return [
            "status": status,
            "error": error,
            "cities": cities
        ]
    }
}
