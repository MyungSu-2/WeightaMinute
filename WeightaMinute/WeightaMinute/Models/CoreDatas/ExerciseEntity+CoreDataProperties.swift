//
//  ExerciseEntity+CoreDataProperties.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//
//

import Foundation
import CoreData


extension ExerciseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseEntity> {
        return NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var category: String?

}

extension ExerciseEntity : Identifiable {

}
