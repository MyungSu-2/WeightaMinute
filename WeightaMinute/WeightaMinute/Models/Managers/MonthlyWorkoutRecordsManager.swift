//
//  MonthlyWorkoutRecordsManager.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/23/25.
//

import UIKit

// MARK: - 월간 운동 기록 매니저
final class MonthlyWorkoutRecordsManager {
    // 싱글톤 객체 생성
    static let shared = MonthlyWorkoutRecordsManager()
    private init() {}
    
    // 매니저 내에 저장하고 관리하는 운동 기록 딕셔너리
    private var monthlyRecordDict: [DateComponents: [WorkoutRecord]] = [:]
    
    // 운동 기록 딕셔너리 getter
    func getMonthlyRecordDict() -> [DateComponents: [WorkoutRecord]] { monthlyRecordDict }
    
    // 테스트용 운동 기록 딕셔너리 getter
    func getTestRecordDict() -> [DateComponents: [WorkoutRecord]] {
        let testDateComponents1 = DateComponents(year: 2025, month: 5, day: 5)
        let testDateComponents2 = DateComponents(year: 2025, month: 5, day: 8)
        let testDateComponents3 = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let testWorkoutRecord = WorkoutRecord(date: Date(), sessions: [WorkoutSession(exercise: "Bench Press", sets: [ExerciseSet(weight: 100, reps: 12)])])
        var testDict: [DateComponents: [WorkoutRecord]] = [:]
        testDict[testDateComponents1, default: []].append(testWorkoutRecord)
        testDict[testDateComponents2, default: []].append(testWorkoutRecord)
        testDict[testDateComponents2, default: []].append(testWorkoutRecord)
        testDict[testDateComponents2, default: []].append(testWorkoutRecord)
        testDict[testDateComponents3, default: []].append(testWorkoutRecord)
        testDict[testDateComponents3, default: []].append(testWorkoutRecord)
        
        return testDict
    }
    
    // 날짜 정보를 이용해 그 달의 운동 기록으로 딕셔너리 업데이트
    func loadMonthlyRecord(forMonth dateComponents: DateComponents) {
        monthlyRecordDict = CoreDataManager.shared.fetchMonthlyWorkoutRecords(forMonth: dateComponents)
    }
    
    // DateComponents를 딕셔너리의 키 값으로 사용할 수 있는 DateComponents(년/월/일만 포함)로 변환하는 메서드
    func getKeyFromDateComponents(from dateComponents: DateComponents) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.year, .month, .day], from: calendar.date(from: dateComponents)!)
    }
    
    // 날짜 정보를 받아 딕셔너리의 키 값으로 변환 후 해당 날짜의 운동 기록 배열을 반환하는 메서드
    func getDailyWorkoutRecord(forDay dateComponents: DateComponents) -> [WorkoutRecord]? {
        let key = getKeyFromDateComponents(from: dateComponents)
        return getMonthlyRecordDict()[key]
    }
    
    // 운동 기록이 있는 날들을 [DateComponents] 형태로 반환하는 메서드
    func getDateComponentsToReload() -> [DateComponents] {
        getMonthlyRecordDict().keys.map { $0 }
    }
}
