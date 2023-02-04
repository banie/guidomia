//
//  CarDetail.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

struct CarDetail: Codable, Equatable {
    let model: String
    let make: String
    let customerPrice: Double
    let marketPrice: Double
    let prosList: [String]
    let consList: [String]
    let rating: Int
}

extension CarDetail: Identifiable {
    var id: String {
        return model + "-" + make
    }
}
