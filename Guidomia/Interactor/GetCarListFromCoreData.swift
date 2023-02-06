//
//  GetCarListFromCoreData.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-05.
//

import Foundation
import CoreData

class GetCarListFromCoreData: GetCarListApi {
    func getListOfCarDetails() throws -> [CarDetail]? {
        let carManagedObjects: [CarDetailManagedObject]
        let fetchRequest: NSFetchRequest<CarDetailManagedObject> = CarDetailManagedObject.fetchRequest()
        let sortByMake = NSSortDescriptor(key: #keyPath(CarDetailManagedObject.make), ascending: true)
        fetchRequest.sortDescriptors = [sortByMake]
        do {
            carManagedObjects = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            carManagedObjects = []
        }

        
        let carDetails = carManagedObjects.map { carManagedObject in
            let prosList = (carManagedObject.prosList as? Set<ProReasonManagedObject>)?.map {
                $0.reason
            } ?? []
            let consList = (carManagedObject.consList as? Set<ConReasonManagedObject>)?.map {
                $0.reason
            } ?? []
            return CarDetail(id: carManagedObject.id, model: carManagedObject.model, make: carManagedObject.make, customerPrice: Double(carManagedObject.customerPrice), marketPrice: Double(carManagedObject.marketPrice), prosList: prosList, consList: consList, rating: carManagedObject.rating)
        }
        
        return carDetails
    }
}
