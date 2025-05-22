//
//  WorkoutSessionEntity+CoreDataProperties.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//
//

import Foundation
import CoreData


extension WorkoutSessionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutSessionEntity> {
        return NSFetchRequest<WorkoutSessionEntity>(entityName: "WorkoutSessionEntity")
    }

    @NSManaged public var exercise: String?
    @NSManaged public var sets: NSOrderedSet?
    @NSManaged public var belongedRecord: WorkoutRecordEntity?

}

// MARK: Generated accessors for sets
extension WorkoutSessionEntity {

    @objc(insertObject:inSetsAtIndex:)
    @NSManaged public func insertIntoSets(_ value: ExerciseSetEntity, at idx: Int)

    @objc(removeObjectFromSetsAtIndex:)
    @NSManaged public func removeFromSets(at idx: Int)

    @objc(insertSets:atIndexes:)
    @NSManaged public func insertIntoSets(_ values: [ExerciseSetEntity], at indexes: NSIndexSet)

    @objc(removeSetsAtIndexes:)
    @NSManaged public func removeFromSets(at indexes: NSIndexSet)

    @objc(replaceObjectInSetsAtIndex:withObject:)
    @NSManaged public func replaceSets(at idx: Int, with value: ExerciseSetEntity)

    @objc(replaceSetsAtIndexes:withSets:)
    @NSManaged public func replaceSets(at indexes: NSIndexSet, with values: [ExerciseSetEntity])

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: ExerciseSetEntity)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: ExerciseSetEntity)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSOrderedSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSOrderedSet)
    
    var setsArray: [ExerciseSetEntity] {
        return sets?.array as? [ExerciseSetEntity] ?? []
    }
    
}

extension WorkoutSessionEntity : Identifiable {

}
