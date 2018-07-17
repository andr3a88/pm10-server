//
//  BaseResponse.swift
//  App
//
//  Created by Andrea Stevanato on 17/07/2018.
//

import Vapor

protocol BaseResponseType: Content {

    var status: String? { get set }
}

protocol BaseItemResponseType: Codable {

    associatedtype D
    var item: D { get set }
}

protocol BaseItemsResponseType: Codable {

    associatedtype D
    var items: D { get set }
}
