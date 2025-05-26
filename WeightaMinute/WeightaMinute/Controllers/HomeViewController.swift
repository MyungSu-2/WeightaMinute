//
//  ViewController.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/19/25.
//

import UIKit

final class HomeViewController: UIViewController {
    // 달력에 표시할 날짜 배열
    private var daysToDisplay: [Date] = []
    
    // MARK: - 뷰 컨트롤러 기본 설정
    // 커스텀 뷰 사용
    private let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecord()
        setupCalendarView()
        setupTableView()
        setupActions()
    }
    
    // 현재 월의 기록 불러오기
    private func setupRecord() {
        // 현재 월 정보 저장 및 현재 월의 운동 기록 불러오기
        MonthlyWorkoutRecordsManager.shared.setCurrentMonth(to: Calendar.current.dateComponents([.year, .month], from: Date()))
        MonthlyWorkoutRecordsManager.shared.loadMonthlyRecord()
        
        // MARK: - 테스트용 데이터로 변경
        MonthlyWorkoutRecordsManager.shared.setTestRecordDict()
        
        MonthlyWorkoutRecordsManager.shared.setMonthlyRecordArray()
    }
    
    // 캘린더 뷰 설정
    private func setupCalendarView() {
        homeView.homeCalendarView.calendarBody.dataSource = self
        homeView.homeCalendarView.calendarBody.delegate = self
        homeView.homeCalendarView.calendarBody.register(HomeCalendarCell.self, forCellWithReuseIdentifier: "HomeCalendarCell")
        updateCalendar(forMonth: MonthlyWorkoutRecordsManager.shared.getCurrentMonth())
    }

    // 테이블 뷰 설정
    private func setupTableView() {
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    // 타겟 함수 등록
    private func setupActions() {
        homeView.homeCalendarView.prevButton.addTarget(self, action: #selector(prevMonthButtonTapped), for: .touchUpInside)
        homeView.homeCalendarView.nextButton.addTarget(self, action: #selector(nextMonthButtonTapped), for: .touchUpInside)
        homeView.recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        // 운동 관리 버튼, 피드백 관리 버튼 추가
    }
    
    // MARK: - 캘린더 업데이트 관련 메서드
    private func updateCalendar(forMonth dateComponents: DateComponents) {
        // 달력에 표시 중인 월 정보 텍스트 변경
        homeView.homeCalendarView.calendarMonthLabel.text = formattedMonthAndYear(from: Calendar.current.date(from: dateComponents)!)
        
        // 달력에 표시할 날짜 계산
        daysToDisplay = getDaysToDisplay(from: dateComponents)
        
        // 커스텀 캘린더 다시 불러오기
        homeView.homeCalendarView.calendarBody.reloadData()
    }
    
    // 월 정보를 문자열 형태로 반환하는 메서드
    private func formattedMonthAndYear(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: date)
    }
    
    // 달력에 표시할 날짜 배열을 계산하는 메서드
    private func getDaysToDisplay(from dateComponents: DateComponents) -> [Date] {
        var result: [Date] = []
        let calendar = Calendar.current
        
        guard let firstDay = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: firstDay) else { return result }
        
        // 해당 월 첫 날의 요일을 이용해 달력에 표시될 이전 달 날짜의 수 계산
        let lastMonthOffset = calendar.component(.weekday, from: firstDay) - 1
        
        for _ in 0 ..< lastMonthOffset {
            result.append(Date.distantPast)
        }
        
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                result.append(date)
            }
        }
        
        return result
    }
    
    // MARK: - 타겟 메서드
    @objc private func prevMonthButtonTapped() {
        // 저장 중인 월 정보 변경 후, 해당 월의 기록 불러오기, 해당 월로 캘린더 업데이트
        let calendar = Calendar.current
        guard let currentDate = calendar.date(from: MonthlyWorkoutRecordsManager.shared.getCurrentMonth()),
              let updateDate = calendar.date(byAdding: .month, value: -1, to: currentDate) else { return }
        MonthlyWorkoutRecordsManager.shared.setCurrentMonth(to: calendar.dateComponents([.year, .month], from: updateDate))
        MonthlyWorkoutRecordsManager.shared.loadMonthlyRecord()
        updateCalendar(forMonth: MonthlyWorkoutRecordsManager.shared.getCurrentMonth())
    }
    
    @objc private func nextMonthButtonTapped() {
        // 저장 중인 월 정보 변경 후, 해당 월의 기록 불러오기, 해당 월로 캘린더 업데이트
        let calendar = Calendar.current
        guard let currentDate = calendar.date(from: MonthlyWorkoutRecordsManager.shared.getCurrentMonth()),
              let updateDate = calendar.date(byAdding: .month, value: 1, to: currentDate) else { return }
        MonthlyWorkoutRecordsManager.shared.setCurrentMonth(to: calendar.dateComponents([.year, .month], from: updateDate))
        MonthlyWorkoutRecordsManager.shared.loadMonthlyRecord()
        updateCalendar(forMonth: MonthlyWorkoutRecordsManager.shared.getCurrentMonth())
    }
    
    @objc private func recordButtonTapped() {
        // 화면 이동 구현
        print("운동 기록 버튼 눌림")
    }
}

// MARK: - 커스텀 캘린더 날짜 및 기록 표시
// UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    // 해당 월의 날짜 수만큼 아이템 표시
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysToDisplay.count
    }
    
    // 컬렉션 뷰 아이템에 날짜 정보 및 운동 기록 수 전달
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 등록한 셀 불러오기
        let cell = homeView.homeCalendarView.calendarBody.dequeueReusableCell(withReuseIdentifier: "HomeCalendarCell", for: indexPath) as! HomeCalendarCell
        let date = daysToDisplay[indexPath.item]
        let weekday = Calendar.current.component(.weekday, from: date)
        let dailyRecords = MonthlyWorkoutRecordsManager.shared.getDailyWorkoutRecord(forDay: date)
        let recordCount = dailyRecords?.count ?? 0
        let dotCount = min(recordCount, 3)
        
        // 요일에 따른 날짜 표시 색상 설정
        var dateColor = Constants.Color.calendarText
        switch weekday {
        case 1:
            dateColor = Constants.Color.calendarSunday
        case 7:
            dateColor = Constants.Color.calendarSaturday
        default:
            dateColor = Constants.Color.calendarText
        }
        
        // 오늘 날짜 표시 색상 설정
        if let today = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Date())) {
            if date == today {
                dateColor = Constants.Color.calendarToday
            }
        }
        
        // 날짜가 이전 달인 경우 날짜 표시하지 않음
        if date == Date.distantPast {
            cell.configure(date: 0, dateColor: dateColor, recordCount: dotCount)
        } else {
            cell.configure(date: Calendar.current.component(.day, from: date), dateColor: dateColor, recordCount: dotCount)
        }
        
        return cell
    }
    
}

// UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // 컬레션 뷰 아이템의 크기를 결정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = homeView.homeCalendarView.calendarBody.bounds.width / 7
        let height = Constants.Size.calendarBodyHeight / 6
        return CGSize(width: width, height: height)
    }
}

// MARK: - 커스텀 캘린더 상세 화면 이동
// UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 해당 날짜의 기록 불러오기
        let date = daysToDisplay[indexPath.item]
        let dailyRecords = MonthlyWorkoutRecordsManager.shared.getDailyWorkoutRecord(forDay: date) ?? []
        
        // 기록이 없는 경우 동작하지 않음
        guard !dailyRecords.isEmpty else { return }
        
        // 기록이 있는 경우 다음 화면에 기록을 전달하며 다음 화면으로 이동
        let detailVC = WorkoutRecordDetailViewController(records: dailyRecords)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - 테이블 뷰 구현
// UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    // 테이블 뷰에 표시할 셀의 개수 결정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 해당 월의 운동 기록이 없으면 1, 있으면 운동 기록의 수 반환
        let records = MonthlyWorkoutRecordsManager.shared.getMonthlyRecordArr()
        return records.isEmpty ? 1 : records.count
    }
    
    // 표시할 테이블 뷰 셀 결정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let records = Array(MonthlyWorkoutRecordsManager.shared.getMonthlyRecordArr().reversed())
        if records.isEmpty {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "EmptyCell")
            cell.textLabel?.text = Constants.Message.emptyWorkoutRecord
            cell.textLabel?.textColor = Constants.Color.secondaryText
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            let record = records[indexPath.row]
            cell.configure(with: record.date)
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

// UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    // 테이블 뷰 셀 선택 시 실행
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 현재 월 전체 운동 기록 배열 저장
        let records = Array(MonthlyWorkoutRecordsManager.shared.getMonthlyRecordArr().reversed())
        // 운동 기록이 없을 경우 이동하지 않음
        guard !records.isEmpty else { return }
        
        // 현재 표시 중인 기록을 상세 화면에 전달하며 이동
        let record = records[indexPath.row]
        let detailVC = WorkoutRecordDetailViewController(records: [record])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
