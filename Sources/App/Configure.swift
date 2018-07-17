import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig()
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(CustomErrorMiddleware.self)
    services.register(middlewares)
}
