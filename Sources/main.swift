//
//  main.swift
//  pm10-server
//
//  Created by Andrea on 28/10/2017.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
var routes = Routes()

routes.add(method: .get, uri: "/", handler: {
    request, response in

    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Developed in Swift</title><body>Developed in Swift</body></html>")
    response.completed()
})

routes.add(method: .get, uri: "/api/pm10", handler: {
    request, response in
    
    let parser = WebPageParser(url: Configuration.ArpavUrl)
    parser.fetchCityPage(completion: { (success, cities, error) in
        response.setHeader(.contentType, value: "application/json")
        if success {
            try! response.setBody(json: CityListResponse(cities: cities!).getJSONValues())
        } else {
            try! response.setBody(json: CityListResponse(error: error!).getJSONValues())
        }
        response.completed()
    })
})

server.addRoutes(routes)
server.serverPort = 8181

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
