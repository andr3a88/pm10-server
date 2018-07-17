//
//  CityListResponse.swift
//  App
//
//  Created by Andrea Stevanato on 16/07/2018.
//

import Vapor

struct ItemsResponse<T: Content>: BaseResponseType, BaseItemsResponseType {

    typealias D = [T]
    
    // MARK: Properties

    var status: String?
    var items: [T]

    // MARK: Methods

    init(items: [T]) {
        self.items = items
        self.status = "ok"
    }
}
