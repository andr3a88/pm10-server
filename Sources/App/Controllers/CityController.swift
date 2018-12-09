import Vapor

struct CityController: RouteCollection {

    static let stubbedData: Bool = false

    func boot(router: Router) throws {

        let cityRoutes = router.grouped("api", "pm10")
        cityRoutes.get(use: getCityHandler)
    }

    func getCityHandler(_ req: Request) throws -> Future<ItemsResponse<City>> {
        let parser = WebPageParser(url: Configuration.ArpavUrl)

        let promise = req.eventLoop.newPromise(ItemsResponse<City>.self)
        do {
            let cities = CityController.stubbedData ? City.stubbed() : try parser.fetchCityPage()
            print("\(cities.description)")
            promise.succeed(result: ItemsResponse(items: cities))
        } catch let error as WebPageParsingError {
            print("\(error.debugDescription)")
            promise.fail(error: error)
        }
        return promise.futureResult
    }
}



