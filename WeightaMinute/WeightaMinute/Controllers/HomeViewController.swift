//
//  ViewController.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/19/25.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - 뷰 컨트롤러 기본 설정
    // 커스텀 뷰 사용
    private let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        setupTableView()
        setupActions()
    }
    
    // 캘린더 뷰 설정
    private func setupCalendarView() {
        homeView.calendarView.delegate = self
        homeView.calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        
        let currentMonth = Calendar.current.dateComponents([.year, .month], from: Date())
        loadMonthlyRecordsAndReloadCalendar(forMonth: currentMonth)
    }

    // 테이블 뷰 설정
    private func setupTableView() {
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "homeTableViewCell")
    }
    
    // 타겟 함수 등록
    private func setupActions() {
        homeView.recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
    }
    
    @objc private func recordButtonTapped() {
        // 화면 이동 구현
        print("운동 기록 버튼 눌림")
    }
}

// MARK: - 캘린더 뷰 기록 표시
extension HomeViewController: UICalendarViewDelegate {
    // 캘린더 뷰 리로드 시 호출하여 해당 날짜의 데코레이션을 결정하는 메서드
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        // 현재 표시하려는 날짜에 해당하는 기록 불러오기
        let dailyRecords = MonthlyWorkoutRecordsManager.shared.getDailyWorkoutRecord(forDay: dateComponents)
        var recordCount = dailyRecords?.count ?? 0
        
        // 기록이 없는 경우 표시하지 않음
        guard recordCount > 0 else { return nil }
        
        switch recordCount {
        case 1:
            return .default(color: Constants.Color.calendarDotColorLevel1)
        case 2:
            return .default(color: Constants.Color.calendarDotColorLevel2)
        default:
            return .default(color: Constants.Color.calendarDotColorLevel3)
        }
    }
    
    // 캘린더에 표시 중인 월 변경 시 호출
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        loadMonthlyRecordsAndReloadCalendar(forMonth: calendarView.visibleDateComponents)
    }
    
    // 특정 월의 운동 기록을 불러오고, 불러온 운동 기록을 캘린더에 표시하는 메서드
    func loadMonthlyRecordsAndReloadCalendar(forMonth dateComponents: DateComponents) {
        MonthlyWorkoutRecordsManager.shared.loadMonthlyRecord(forMonth: dateComponents)
        homeView.calendarView.reloadDecorations(forDateComponents: MonthlyWorkoutRecordsManager.shared.getDateComponentsToReload(), animated: true)
    }
}

// MARK: - 캘린더 뷰 화면 이동
extension HomeViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        // 선택한 날짜에 해당하는 기록 불러오기
        guard let dateComponents = dateComponents else { return }
        let dailyRecords = MonthlyWorkoutRecordsManager.shared.getDailyWorkoutRecord(forDay: dateComponents) ?? []
        
        // 기록이 없는 경우 동작하지 않음
        guard !dailyRecords.isEmpty else {
            return
        }
        
        // 기록이 있는 경우 다음 화면에 기록을 전달하며 다음 화면으로 이동
        let detailVC = WorkoutRecordDetailViewController(records: dailyRecords)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - 테이블 뷰 구현
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath)
        
        return cell
    }
}
