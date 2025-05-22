//
//  Exercise.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//

import UIKit

// MARK: - 운동 목록
// 운동 구조체
struct Exercise {
    var name: String
    var category: ExerciseCategory
}

// 운동 부위 열거형
enum ExerciseCategory: String {
    case back, chest, shoulder, biceps, triceps, abs, legs
}
