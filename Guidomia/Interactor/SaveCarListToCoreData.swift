//
//  SaveCarListToCoreData.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-05.
//

import Foundation
import CoreData

class SaveCarListToCoreData: SaveCarListApi {
    let objectContext: NSManagedObjectContext
    
    init(objectContext: NSManagedObjectContext) {
        self.objectContext = objectContext
    }
    
    func save(_ carList: [CarDetail]) throws {
        for carDetail in carList {
            let carManagedObject = CarDetailManagedObject(context: objectContext)
            carManagedObject.id = carDetail.id
            carManagedObject.make = carDetail.make
            carManagedObject.model = carDetail.model
            carManagedObject.customerPrice = Int64(carDetail.customerPrice)
            carManagedObject.marketPrice = Int64(carDetail.marketPrice)
            carManagedObject.rating = Int16(carDetail.rating)
            
            for pro in carDetail.prosList {
                let proObject = ProReasonManagedObject(context: objectContext)
                proObject.carId = carDetail.id
                proObject.reason = pro
                carManagedObject.addToProsList(proObject)
            }
            
            for con in carDetail.consList {
                let conObject = ConReasonManagedObject(context: objectContext)
                conObject.carId = carDetail.id
                conObject.reason = con
                carManagedObject.addToConsList(conObject)
            }
        }
        
        try objectContext.save()
    }
}
