//
//  GetCarListApi.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

protocol GetCarListApi {
    func getListOfCarDetails() throws -> [CarDetail]?
}
