//
//  WebPageParser.swift
//  pm10-server
//
//  Created by Andrea on 28/10/2017.
//

import Foundation
import Kanna

/// A closure executed when the parsing is completed
typealias ParserCompletion = (_ success: Bool, _ data: [City]?, _ error: String?) -> Void

class WebPageParser {
    
    // MARK: Properties

    private let url: String    
    private let numberOfItemsForRow = 8
    
    init(url: String) {
        self.url = url
    }
    
    func fetchCityPage(completion: @escaping ParserCompletion) {
        
        let url = URL(string: self.url)
        if let doc = HTML(url: url!, encoding: .utf8), let content = doc.at_css("#boxcontenuti") {
            
            let table = content.css("table")[1]
            let result = self.parsePM10Table(table: table)
            completion(true, result, nil)
        } else {
            completion(false, nil, "cannot_parse_document")
        }
        
    }
    
    /// Parse the city table
    ///
    /// - Parameter table: The  table element
    /// - Returns: An array of cities
    private func parsePM10Table(table: Kanna.XMLElement) -> [City] {
        var cities = [City]()
        var firstDayTimeInterval: TimeInterval = 0
        
        for (index, row) in table.css("tr").enumerated() {
            // Parse the header of the table to get the first day
            if index == 0 {
                firstDayTimeInterval = self.getFirstDayTimeInterval(row: row)
            }
            
            // Parse the remaining rows
            if index > 1 {
                cities.append(self.parseCity(row: row, firstDayTimeInterval: firstDayTimeInterval))
            }
        }
        return cities
    }
    
    private func getFirstDayTimeInterval(row: Kanna.XMLElement) -> TimeInterval {
        var firstDayTimeInterval: TimeInterval = 0
        
        let element = row.css("td[style=\"text-align:center;\"]").first
        if let dayValue = element?.text?.trim() {
            let firstDayDate = dayValue.substring(from: dayValue.index(dayValue.startIndex, offsetBy: 3))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Configuration.ArpavDateFormat
            firstDayTimeInterval = dateFormatter.date(from: firstDayDate)!.timeIntervalSince1970
        }
        return firstDayTimeInterval
    }
    
    private func parseCity(row: Kanna.XMLElement, firstDayTimeInterval: TimeInterval) -> City {
        let city = City()
        for (index, element) in row.css("td").enumerated() {
            guard let value = element.text?.trim() else { continue }
            if index == 0 {
                city.name = value
            }
            if index > 0 && index < numberOfItemsForRow {
                let timeInterval: TimeInterval = firstDayTimeInterval - Constants.HalfDayTimeInterval + Constants.DayTimeInterval*TimeInterval(index)
                let level = Level(day: timeInterval, value: Int(value)!)
                city.levels.append(level)
            }
            if index >= numberOfItemsForRow {
                continue
            }
        }
        return city
    }
}
