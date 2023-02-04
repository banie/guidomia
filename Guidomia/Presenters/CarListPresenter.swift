//
//  CarListPresenter.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

class CarListPresenter {
    
    var carList: [CarDetail]
    
    init() {
        do {
            carList = try GetCarListInteractor().getListOfCarDetails() ?? []
        } catch {
            carList = []
        }
    }
}
