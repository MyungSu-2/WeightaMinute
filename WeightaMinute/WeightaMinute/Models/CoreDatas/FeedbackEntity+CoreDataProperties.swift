//
//  FeedbackEntity+CoreDataProperties.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//
//

import Foundation
import CoreData


extension FeedbackEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedbackEntity> {
        return NSFetchRequest<FeedbackEntity>(entityName: "FeedbackEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension FeedbackEntity : Identifiable {

}
