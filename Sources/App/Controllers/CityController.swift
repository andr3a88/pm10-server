import Vapor
import Leaf

struct CityController: RouteCollection {

    static let stubbedData: Bool = false

    func boot(router: Router) throws {
        router.grouped("api", "pm10").get(use: getCityHandler)
        router.get("/", use: renderPage)
    }

    func getCityHandler(_ req: Request) throws -> Future<ItemsResponse<City>> {
        return try self.parsePage(req)
    }

    func renderPage(_ req: Request) throws -> Future<View> {
        return try self.parsePage(req).flatMap { results -> Future<View> in
            try req.view().render("pm10", CityContext(title: "PM 10 Veneto", cities: results.items))
        }
    }

    private func parsePage(_ req: Request) throws -> EventLoopFuture<ItemsResponse<City>> {
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

struct CityContext: Encodable {
    var title: String
    var cities: [City]
}
