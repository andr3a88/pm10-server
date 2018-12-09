//
//  WebPageServices.swift
//  App
//
//  Created by Andrea Stevanato on 16/07/2018.
//

import Debugging
import Kanna
import Vapor

/// Errors that can be thrown while working with parsing service.
public struct WebPageParsingError: Debuggable {
    /// See Debuggable.readableName
    public static let readableName = "Parsing error"

    /// See Debuggable.reason
    public let identifier: String

    /// See Debuggable.reason
    public var reason: String

    /// See Debuggable.sourceLocation
    public var sourceLocation: SourceLocation?

    /// See stackTrace
    public var stackTrace: [String]

    /// Create a new authentication error.
    init(identifier: String, reason: String, source: SourceLocation) {
        self.identifier = identifier
        self.reason = reason
        self.sourceLocation = source
        self.stackTrace = WebPageParsingError.makeStackTrace()
    }
}

extension WebPageParsingError: AbortError {
    /// See AbortError.status
    public var status: HTTPStatus {
        return .notFound
    }
}

class WebPageParser {

    // MARK: Properties

    private let url: String
    private let numberOfItemsForRow = 8

    init(url: String) {
        self.url = url
    }

    func fetchCityPage() throws -> [City] {
        let url = URL(string: self.url)
        print("\(url?.absoluteString)")
        let doc = try HTML(url: url!, encoding: .utf8)
        print("\(doc.text)")
        let content = doc.at_css("#boxcontenuti")
        if let table = content?.css("table"), table.count > 1 {
            return self.parsePM10Table(table: table[1])
        } else {
            let error = WebPageParsingError(
                identifier: "parsing_error",
                reason: "parsing_error",
                source: .capture()
            )
            throw error
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
        var city = City()
        for (index, element) in row.css("td").enumerated() {
            guard let value = element.text?.trim() else { continue }
            if index == 0 {
                city.name = value
            }
            if index > 0 && index < numberOfItemsForRow {
                let timeInterval: TimeInterval = firstDayTimeInterval - Constants.HalfDayTimeInterval + Constants.DayTimeInterval*TimeInterval(index)
                let level = Level(day: timeInterval, value: Int(value) ?? -1)
                city.levels.append(level)
            }
            if index >= numberOfItemsForRow {
                continue
            }
        }
        return city
    }
}
