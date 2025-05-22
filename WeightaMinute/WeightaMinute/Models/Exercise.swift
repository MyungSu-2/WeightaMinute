//
//  Exercise.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//

struct Exercise {
    var name: String
    var category: ExerciseCategory
}

enum ExerciseCategory: String {
    case back, chest, shoulder, biceps, triceps, abs, legs
}
