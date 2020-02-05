import Leaf
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    try services.register(LeafProvider())

    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
}
