//
//  ProReasonManagedObject+CoreDataProperties.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-05.
//
//

import Foundation
import CoreData


extension ProReasonManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProReasonManagedObject> {
        return NSFetchRequest<ProReasonManagedObject>(entityName: "ProReasonManagedObject")
    }

    @NSManaged public var reason: String
    @NSManaged public var carId: UUID
    @NSManaged public var carDetail: CarDetailManagedObject?

}

extension ProReasonManagedObject : Identifiable {

}
