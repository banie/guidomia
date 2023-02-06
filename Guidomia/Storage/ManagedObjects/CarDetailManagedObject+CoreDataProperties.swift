//
//  CarDetailManagedObject+CoreDataProperties.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-05.
//
//

import Foundation
import CoreData


extension CarDetailManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarDetailManagedObject> {
        return NSFetchRequest<CarDetailManagedObject>(entityName: "CarDetailManagedObject")
    }

    @NSManaged public var model: String
    @NSManaged public var make: String
    @NSManaged public var customerPrice: Int64
    @NSManaged public var marketPrice: Int64
    @NSManaged public var id: UUID
    @NSManaged public var rating: Int
    @NSManaged public var prosList: NSSet?
    @NSManaged public var consList: NSSet?

}

// MARK: Generated accessors for prosList
extension CarDetailManagedObject {

    @objc(addProsListObject:)
    @NSManaged public func addToProsList(_ value: ProReasonManagedObject)

    @objc(removeProsListObject:)
    @NSManaged public func removeFromProsList(_ value: ProReasonManagedObject)

    @objc(addProsList:)
    @NSManaged public func addToProsList(_ values: NSSet)

    @objc(removeProsList:)
    @NSManaged public func removeFromProsList(_ values: NSSet)

}

// MARK: Generated accessors for consList
extension CarDetailManagedObject {

    @objc(addConsListObject:)
    @NSManaged public func addToConsList(_ value: ConReasonManagedObject)

    @objc(removeConsListObject:)
    @NSManaged public func removeFromConsList(_ value: ConReasonManagedObject)

    @objc(addConsList:)
    @NSManaged public func addToConsList(_ values: NSSet)

    @objc(removeConsList:)
    @NSManaged public func removeFromConsList(_ values: NSSet)

}

extension CarDetailManagedObject : Identifiable {

}
