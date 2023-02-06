//
//  SaveCarListApi.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-05.
//

import Foundation

protocol SaveCarListApi {
    func save(_ carList: [CarDetail]) throws
}
