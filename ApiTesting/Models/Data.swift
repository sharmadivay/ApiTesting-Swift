//
//  Data.swift
//  ApiTesting
//
//  Created by Divay Sharma on 14/04/25.
//

import Foundation

struct Data : Codable {
    let categories: [Categories]
    let populars: [Populars]
    let specials: [Specials]
}

struct ApiResponse: Codable {
    let data: Data
}
