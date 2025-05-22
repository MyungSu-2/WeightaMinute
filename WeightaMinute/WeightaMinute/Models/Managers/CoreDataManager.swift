//
//  CoreDataManager.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/22/25.
//

import UIKit
import CoreData

final class CoreDataManager {
    // MARK: - 코어 데이터 매니저 설정
    // 싱글톤 객체 생성
    static let shared = CoreDataManager()
    private init() {}
    
    // 영구 저장소의 context를 저장할 속성
    var context: NSManagedObjectContext!
    
    // 외부에서 context를 주입하기 위한 함수
    func setContext(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // context의 변경 사항을 영구 저장소에 반영
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data Save Error: \(error)")
            }
        }
    }
    
    // MARK: - 운동 기록 관리
    // 새로운 운동 기록 추가하기 (WorkoutRecord -> WorkoutRecordEntity)
    func addWorkoutRecord(_ record: WorkoutRecord) {
        // WorkoutRecordEntity 생성 및 date 입력
        let recordEntity = WorkoutRecordEntity(context: context)
        recordEntity.date = record.date
        
        // WorkoutSessionEntity 생성 및 WorkoutRecordEntity에 연결
        for session in record.sessions {
            let sessionEntity = WorkoutSessionEntity(context: context)
            sessionEntity.exercise = session.exercise
            sessionEntity.belongedRecord = recordEntity
            
            // ExerciseSetEntity 생성 및 WorkoutSessionEntity에 연결
            for set in session.sets {
                let setEntity = ExerciseSetEntity(context: context)
                setEntity.weight = set.weight
                setEntity.reps = set.reps
                setEntity.belongedSession = sessionEntity
            }
        }
        // context 변경 사항 반영
        saveContext()
    }
    
    // 특정 월의 운동 기록 불러오기 (WorkoutRecordEntity -> WorkoutRecord)
    // [DateComponents: [WorkoutRecord]] 반환
    func fetchMonthlyWorkoutRecords(forMonth dateComponents: DateComponents) -> [DateComponents: [WorkoutRecord]] {
        let calendar = Calendar.current
        // 전달한 날짜가 속한 달의 첫 날과 다음 달 첫 날을 이용하여 특정 월에 속한 날짜 구분
        guard let startOfMonth = calendar.date(from: dateComponents),
              let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)
        else { return [:] }
        
        // date가 특정 월에 속하는 기록들만 fetch하는 요청 생성
        let request: NSFetchRequest<WorkoutRecordEntity> = WorkoutRecordEntity.fetchRequest()
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfMonth as NSDate, endOfMonth as NSDate)
        request.predicate = predicate
        
        do {
            // 조건에 해당하는 기록들을 fetch, WorkoutRecord로 변환하여 날짜를 키로 하는 딕셔너리에 담아 반환
            var recordDict: [DateComponents: [WorkoutRecord]] = [:]
            let recordEntities = try context.fetch(request)
            recordEntities.forEach { recordEntity in
                let sessions = recordEntity.sessionsArray.map { sessionEntity in
                    let sets = sessionEntity.setsArray.map {
                        ExerciseSet(weight: $0.weight, reps: $0.reps)
                    }
                    return WorkoutSession(exercise: sessionEntity.exercise ?? "", sets: sets)
                }
                let dateComponents = calendar.dateComponents([.year, .month, .day], from: recordEntity.date!)
                recordDict[dateComponents, default:[]].append(WorkoutRecord(date: recordEntity.date ?? Date(), sessions: sessions))
            }
            return recordDict
        } catch {
            print("Workout records fetching error: \(error)")
            return [:]
        }
    }
    
    // 운동 기록 삭제하기 (WorkoutRecord -> WorkoutRecordEntity)
    func deleteWorkoutRecord(_ record: WorkoutRecord) {
        // WorkoutRecord에 해당하는 Entity를 찾기 위한 요청 생성
        let request: NSFetchRequest<WorkoutRecordEntity> = WorkoutRecordEntity.fetchRequest()
        let predicate = NSPredicate(format: "date == %@", record.date as CVarArg)
        request.predicate = predicate
        
        // 정의한 요청으로 fetch한 결과 Entity들을 context에서 삭제
        do {
            let workoutRecordEntities = try context.fetch(request)
            workoutRecordEntities.forEach {
                context.delete($0)
                saveContext()
            }
        } catch {
            print("WorkoutRecord Deletion error: \(error)")
        }
    }
    
    // MARK: - 피드백 관리
    // 새로운 피드백 추가하기 (Feedback -> FeedbackEntity)
    func addFeedback(_ feedback: Feedback) {
        let feedbackEntity = FeedbackEntity(context: context)
        feedbackEntity.date = feedback.date
        feedbackEntity.text = feedback.text
        saveContext()
    }
    
    // 전체 피드백 날짜 순으로 불러오기 (FeedbackEntity -> Feedback)
    func fetchFeedbacks() -> [Feedback] {
        // 날짜 순으로 불러오는 요청 생성
        let request: NSFetchRequest<FeedbackEntity> = FeedbackEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        // 정의한 요청으로 fetch한 결과 Entity들을 Feedback 구조체로 매핑하여 반환
        do {
            let feedbackEntities = try context.fetch(request)
            return feedbackEntities.map {
                Feedback(date: $0.date ?? Date(), text: $0.text ?? "")
            }
        } catch {
            print("Feedbacks fetching error: \(error)")
            return []
        }
    }
    
    // 피드백 삭제하기 (Feedback -> FeedbackEntity)
    func deleteFeedback(_ feedback: Feedback) {
        // Feedback에 해당하는 Entity를 찾기 위한 요청 생성
        let request: NSFetchRequest<FeedbackEntity> = FeedbackEntity.fetchRequest()
        let predicate = NSPredicate(format: "date == %@ AND text == %@", feedback.date as NSDate, feedback.text)
        request.predicate = predicate
        
        // 정의한 요청으로 fetch한 결과 Entity들을 context에서 삭제
        do {
            let feedbackEntities = try context.fetch(request)
            feedbackEntities.forEach {
                context.delete($0)
            }
            saveContext()
        } catch {
            print("Feedback deletion error: \(error)")
        }
    }
    
    // MARK: - 운동 종류 관리
    // 새로운 운동 추가하기 (Exercise - > ExerciseEntity)
    func addExercise(_ exercise: Exercise) {
        let exerciseEntity = ExerciseEntity(context: context)
        exerciseEntity.name = exercise.name
        exerciseEntity.category = exercise.category.rawValue
        saveContext()
    }
    
    // 전체 운동 목록 불러오기 (카테고리 / 이름 순서) (ExerciseEntity -> Exercise)
    func fetchExercises() -> [Exercise] {
        // 카테고리 순 > 이름 순으로 전체 운동 목록을 불러오는 요청 생성
        let request: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        let sortByCategory = NSSortDescriptor(key: "category", ascending: true)
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByCategory, sortByName]
        
        // 정의한 요청으로 fetch한 결과 Entity들을 Exercise 구조체로 매핑하여 반환
        do {
            let exerciseEntities = try context.fetch(request)
            return exerciseEntities.map {
                Exercise(name: $0.name ?? "", category: ExerciseCategory(rawValue: $0.category ?? "back") ?? .back)
            }
        } catch {
            print("Exercises fetching error: \(error)")
            return []
        }
    }
    
    // 운동 삭제하기 (Exercise -> ExerciseEntity)
    func deleteExercise(_ exercise: Exercise) {
        // Exercise에 해당하는 Entity를 찾기 위한 요청 생성
        let request: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        let predicate = NSPredicate(format: "name == %@ AND category == %@", exercise.name, exercise.category.rawValue)
        request.predicate = predicate
        
        // 정의한 요청으로 fetch한 결과 Entity들을 context에서 삭제
        do {
            let exerciseEntities = try context.fetch(request)
            exerciseEntities.forEach {
                context.delete($0)
            }
            saveContext()
        } catch {
            print("Exercise deletion error: \(error)")
        }
    }
}
