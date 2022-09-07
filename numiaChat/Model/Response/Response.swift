//
//  Response.swift
//  Mappa
//
//  Created by Kamil Suleymanov on 15.08.2022.
//

import Foundation

struct Response<T: Codable>: Codable {
    let status: Bool?
    let items: T?
}
