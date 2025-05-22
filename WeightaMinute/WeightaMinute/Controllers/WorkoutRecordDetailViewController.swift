//
//  WorkoutRecordDetailViewController.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/23/25.
//

import UIKit

// MARK: - 운동 기록 상세 화면
class WorkoutRecordDetailViewController: UIViewController {
    var workoutRecords: [WorkoutRecord]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        print(workoutRecords!)
    }
    
    init(records: [WorkoutRecord]) {
        self.workoutRecords = records
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
