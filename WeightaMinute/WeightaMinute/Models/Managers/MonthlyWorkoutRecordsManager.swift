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
    
    // 현재 저장 중인 기록의 월 정보
    private var currentMonth: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
    
    // 매니저 내에 저장하고 관리하는 운동 기록 딕셔너리
    private var monthlyRecordDict: [DateComponents: [WorkoutRecord]] = [:]
    private var monthlyRecordArr: [WorkoutRecord] = []
    
    // 현재 월 정보 getter / setter
    func getCurrentMonth() -> DateComponents { currentMonth }
    func setCurrentMonth(to dateComponents: DateComponents) { currentMonth = dateComponents }
    
    // 운동 기록 딕셔너리 getter
    func getMonthlyRecordDict() -> [DateComponents: [WorkoutRecord]] { monthlyRecordDict }
    
    // 운동 기록 배열 getter
    func getMonthlyRecordArr() -> [WorkoutRecord] { monthlyRecordArr }
    
    // 테스트용 운동 기록 딕셔너리 setter
    func setTestRecordDict() {
        let testDate1 = Calendar.current.date(from:DateComponents(year: 2025, month: 5, day: 5))!
        let testDateComponents1 = Calendar.current.dateComponents([.year, .month, .day], from: testDate1)
        let testDate2 = Calendar.current.date(from:DateComponents(year: 2025, month: 5, day: 8))!
        let testDateComponents2 = Calendar.current.dateComponents([.year, .month, .day], from: testDate2)
        let testDateComponents3 = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let testWorkoutRecord1 = WorkoutRecord(date: testDate1, sessions: [WorkoutSession(exercise: "Bench Press", sets: [ExerciseSet(weight: 100, reps: 12)])])
        let testWorkoutRecord2 = WorkoutRecord(date: testDate2, sessions: [WorkoutSession(exercise: "Bench Press", sets: [ExerciseSet(weight: 100, reps: 12)])])
        let testWorkoutRecord3 = WorkoutRecord(date: Date(), sessions: [WorkoutSession(exercise: "Bench Press", sets: [ExerciseSet(weight: 100, reps: 12)])])
        var testDict: [DateComponents: [WorkoutRecord]] = [:]
        testDict[testDateComponents1, default: []].append(testWorkoutRecord1)
        testDict[testDateComponents2, default: []].append(testWorkoutRecord2)
        testDict[testDateComponents2, default: []].append(testWorkoutRecord2)
        testDict[testDateComponents2, default: []].append(testWorkoutRecord2)
        testDict[testDateComponents3, default: []].append(testWorkoutRecord3)
        testDict[testDateComponents3, default: []].append(testWorkoutRecord3)
        
        monthlyRecordDict = testDict
    }
    
    // 날짜 정보를 이용해 그 달의 운동 기록으로 딕셔너리 업데이트
    func loadMonthlyRecord() {
        monthlyRecordDict = CoreDataManager.shared.fetchMonthlyWorkoutRecords(forMonth: currentMonth)
    }
    
    // Date를 딕셔너리의 키 값으로 사용할 수 있는 DateComponents(년/월/일만 포함)로 변환하는 메서드
    private func getKeyFromDate(from date: Date) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.year, .month, .day], from: date)
    }
    
    // 날짜 정보를 받아 딕셔너리의 키 값으로 변환 후 해당 날짜의 운동 기록 배열을 반환하는 메서드
    func getDailyWorkoutRecord(forDay date: Date) -> [WorkoutRecord]? {
        let key = getKeyFromDate(from: date)
        return getMonthlyRecordDict()[key]
    }
    
    // 현재 월의 전체 운동 기록을 날짜 순으로 정렬한 하나의 배열로 반환하는 메서드
    func setMonthlyRecordArray() {
        let calendar = Calendar.current
        
        // 기록이 있는 날짜들을 정렬
        let sortedKeys = monthlyRecordDict.keys.sorted {
            guard let date1 = calendar.date(from: $0),
                  let date2 = calendar.date(from: $1) else { return false }
            return date1 < date2
        }
        
        // 각 날짜의 운동 기록들을 하나의 배열에 저장
        monthlyRecordArr = sortedKeys.flatMap { getMonthlyRecordDict()[$0] ?? [] }
    }
}
