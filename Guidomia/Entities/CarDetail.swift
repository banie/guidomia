//
//  CarDetail.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

struct CarDetail: Codable, Identifiable, Equatable {
    let id: UUID
    let model: String
    let make: String
    let customerPrice: Double
    let marketPrice: Double
    let prosList: [String]
    let consList: [String]
    let rating: Int
    
    init(id: UUID = UUID(), model: String, make: String, customerPrice: Double, marketPrice: Double, prosList: [String], consList: [String], rating: Int) {
        self.id = id
        self.model = model
        self.make = make
        self.customerPrice = customerPrice
        self.marketPrice = marketPrice
        self.prosList = prosList
        self.consList = consList
        self.rating = rating
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        model = try container.decode(String.self, forKey: .model)
        make = try container.decode(String.self, forKey: .make)
        customerPrice = try container.decode(Double.self, forKey: .customerPrice)
        marketPrice = try container.decode(Double.self, forKey: .marketPrice)
        prosList = try container.decode([String].self, forKey: .prosList)
        consList = try container.decode([String].self, forKey: .consList)
        rating = try container.decode(Int.self, forKey: .rating)
    }
    
    private enum CodingKeys: String, Swift.CodingKey {
        case model
        case make
        case customerPrice
        case marketPrice
        case prosList
        case consList
        case rating
    }
}
