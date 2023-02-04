//
//  GetCarListInteractor.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

class GetCarListInteractor: GetFromLocalResource, GetCarListApi {
    func getListOfCarDetails() -> [CarDetail] {
        <#code#>
    }
    

    init(localRequestApi: LocalRequestApi = LocalRequestInteractor()) {
        super.init(fileName: "car_list", localRequestApi: localRequestApi)
    }
    
    func getListOfCarDetails() throws -> [CarDetail]? {
        let carList: [CarDetail]? = try get()
        return carList
    }
}

