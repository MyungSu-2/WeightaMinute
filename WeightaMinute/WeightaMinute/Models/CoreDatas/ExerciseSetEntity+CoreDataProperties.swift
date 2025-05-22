//
//  ExerciseSetEntity+CoreDataProperties.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//
//

import Foundation
import CoreData


extension ExerciseSetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSetEntity> {
        return NSFetchRequest<ExerciseSetEntity>(entityName: "ExerciseSetEntity")
    }

    @NSManaged public var weight: Double
    @NSManaged public var reps: Int16
    @NSManaged public var belongedSession: WorkoutSessionEntity?

}

extension ExerciseSetEntity : Identifiable {

}
