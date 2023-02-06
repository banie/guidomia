//
//  ConReasonManagedObject+CoreDataProperties.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-05.
//
//

import Foundation
import CoreData


extension ConReasonManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConReasonManagedObject> {
        return NSFetchRequest<ConReasonManagedObject>(entityName: "ConReasonManagedObject")
    }

    @NSManaged public var reason: String
    @NSManaged public var carId: UUID
    @NSManaged public var carDetail: CarDetailManagedObject?

}

extension ConReasonManagedObject : Identifiable {

}
