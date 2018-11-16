import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get("info") { req in
        return "PM10 Server - Written in Swift"
    }

    let cityController = CityController()
    let alexaController = AlexaController()

    try router.register(collection: cityController)
    try router.register(collection: alexaController)
}
