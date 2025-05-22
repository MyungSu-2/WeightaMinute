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
}
