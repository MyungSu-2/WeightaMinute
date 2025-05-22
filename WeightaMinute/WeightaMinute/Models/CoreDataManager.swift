//
//  CoreDataManager.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//

import UIKit
import CoreData

final class CoreDataManager {
    // 싱글톤 객체 생성
    static let shared = CoreDataManager()
    
    // 앱 델리게이트에서 초기화한 영구 저장소의 context에 접근
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    private init() {}
    
    // MARK: - 운동 기록 관리
    // 새로운 운동 기록 추가하기 (WorkoutRecord -> WorkoutRecordEntity)
    
    // 특정 월의 운동 기록 불러오기 (WorkoutRecordEntity -> WorkoutRecord)
    
    // MARK: - 피드백 관리
    // 새로운 피드백 추가하기 (Feedback -> FeedbackEntity)
    
    // 전체 피드백 불러오기 (FeedbackEntity -> Feedback)
    
    // 피드백 삭제하기 (Feedback -> FeedbackEntity)
    
    // MARK: - 운동 종류 관리
    // 새로운 운동 추가하기 (Exercise - > ExerciseEntity)
    
    // 전체 운동 목록 불러오기 (ExerciseEntity -> Exercise)
    
    // 운동 삭제하기 (Exercise -> ExerciseEntity)
    
}
