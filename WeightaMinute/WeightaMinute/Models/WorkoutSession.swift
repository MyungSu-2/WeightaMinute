//
//  WorkoutSession.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//

import UIKit

// MARK: - 운동 세션 구조체
// 운동 기록 > 세션 > 세트
struct WorkoutSession {
    var exercise: String
    var sets: [ExerciseSet]
}
