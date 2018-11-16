//
//  AlexaController.swift
//  App
//
//  Created by Andrea Stevanato on 16/11/2018.
//

import Vapor

struct AlexaController: RouteCollection {

    static let stubbedData: Bool = false

    func boot(router: Router) throws {

        let routes = router.grouped("api", "alexa")
        routes.post(use: alexaWebhook)
    }

    func alexaWebhook(_ req: Request) throws -> Future<ItemsResponse<City>> {
        let parser = WebPageParser(url: Configuration.ArpavUrl)

        let promise = req.eventLoop.newPromise(ItemsResponse<City>.self)
        do {
            let cities = CityController.stubbedData ? City.stubbed() : try parser.fetchCityPage()
            promise.succeed(result: ItemsResponse(items: cities))
        } catch let error as WebPageParsingError {
            promise.fail(error: error)
        }
        return promise.futureResult
    }
}


