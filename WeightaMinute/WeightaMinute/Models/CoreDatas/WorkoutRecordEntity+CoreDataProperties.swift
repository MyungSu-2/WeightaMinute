//
//  WorkoutRecordEntity+CoreDataProperties.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//
//

import Foundation
import CoreData


extension WorkoutRecordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutRecordEntity> {
        return NSFetchRequest<WorkoutRecordEntity>(entityName: "WorkoutRecordEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var sessions: NSOrderedSet?

}

// MARK: Generated accessors for sessions
extension WorkoutRecordEntity {

    @objc(insertObject:inSessionsAtIndex:)
    @NSManaged public func insertIntoSessions(_ value: WorkoutSessionEntity, at idx: Int)

    @objc(removeObjectFromSessionsAtIndex:)
    @NSManaged public func removeFromSessions(at idx: Int)

    @objc(insertSessions:atIndexes:)
    @NSManaged public func insertIntoSessions(_ values: [WorkoutSessionEntity], at indexes: NSIndexSet)

    @objc(removeSessionsAtIndexes:)
    @NSManaged public func removeFromSessions(at indexes: NSIndexSet)

    @objc(replaceObjectInSessionsAtIndex:withObject:)
    @NSManaged public func replaceSessions(at idx: Int, with value: WorkoutSessionEntity)

    @objc(replaceSessionsAtIndexes:withSessions:)
    @NSManaged public func replaceSessions(at indexes: NSIndexSet, with values: [WorkoutSessionEntity])

    @objc(addSessionsObject:)
    @NSManaged public func addToSessions(_ value: WorkoutSessionEntity)

    @objc(removeSessionsObject:)
    @NSManaged public func removeFromSessions(_ value: WorkoutSessionEntity)

    @objc(addSessions:)
    @NSManaged public func addToSessions(_ values: NSOrderedSet)

    @objc(removeSessions:)
    @NSManaged public func removeFromSessions(_ values: NSOrderedSet)
    
    var sessionsArray: [WorkoutSessionEntity] {
        return sessions?.array as? [WorkoutSessionEntity] ?? []
    }

}

extension WorkoutRecordEntity : Identifiable {

}
