//
//  GetCarListApiMock.swift
//  GuidomiaTests
//
//  Created by Banie Setijoso on 2023-02-06.
//

import Foundation
@testable import Guidomia

class GetCarListApiMock: GetCarListApi {
    var carDetails: [CarDetail]?
    func getListOfCarDetails() throws -> [CarDetail]? {
        carDetails ?? []
    }
}
