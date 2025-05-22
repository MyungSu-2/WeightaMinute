//
//  HomeView.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/19/25.
//

import UIKit

final class HomeView: UIView {
    // MARK: - UI 객체 선언
    // 운동 관리 버튼
    let manageExercisesButton: UIButton = {
        let button = UIButton()
        button.setTitle("운동 관리", for: .normal)
        button.backgroundColor = Constants.Color.buttonBackground
        button.setTitleColor(Constants.Color.buttonText, for: .normal)
        button.layer.cornerRadius = Constants.Size.smallCornerRadius
        return button
    }()
    
    // 피드백 관리 버튼
    let manageFeedbacksButton: UIButton = {
        let button = UIButton()
        button.setTitle("피드백 관리", for: .normal)
        button.backgroundColor = Constants.Color.buttonBackground
        button.setTitleColor(Constants.Color.buttonText, for: .normal)
        button.layer.cornerRadius = Constants.Size.smallCornerRadius
        return button
    }()
    
    // 상단 버튼 스택 뷰
    lazy var topButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [manageExercisesButton, manageFeedbacksButton])
        stackView.spacing = Constants.Size.horizontalMargin
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = . fill
        return stackView
    }()
    
    // 캘린더 뷰 - 홈 화면 달력
    let calendarView: UICalendarView = {
        let calendar = UICalendarView()
        calendar.layer.cornerRadius = Constants.Size.cornerRadius
        calendar.layer.borderColor = Constants.Color.calendarBorder.cgColor
        calendar.layer.borderWidth = Constants.Size.borderWidth
        return calendar
    }()
    
    // 테이블 뷰 - 홈 화면 운동 기록
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Constants.Color.separator
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // 하단 버튼 - 운동 기록하기
    let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("운동 기록하기", for: .normal)
        button.backgroundColor = Constants.Color.buttonBackground
        button.setTitleColor(Constants.Color.buttonText, for: .normal)
        button.layer.cornerRadius = Constants.Size.cornerRadius
        return button
    }()
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 뷰 설정
    private func setupView() {
        backgroundColor = Constants.Color.appBackground
        
        [topButtonsStackView, calendarView, tableView, recordButton].forEach {
            addSubview($0)
        }
    }
    
    // MARK: - 오토레이아웃 설정
    private func setupConstraints() {
        [topButtonsStackView, calendarView, tableView, recordButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // 상단 버튼 - 운동 관리 버튼, 피드백 관리 버튼
            topButtonsStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.Size.homeTopMargin),
            topButtonsStackView.heightAnchor.constraint(equalToConstant: Constants.Size.managementButtonHeight),
            topButtonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.horizontalMargin),
            topButtonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.horizontalMargin),
            
            // 캘린더 뷰 - 홈 화면 달력
            calendarView.topAnchor.constraint(equalTo: topButtonsStackView.bottomAnchor, constant: Constants.Size.homeVerticalSpacing),
            calendarView.heightAnchor.constraint(equalToConstant: Constants.Size.calendarHeight),
            calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.horizontalMargin),
            calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.horizontalMargin),
            
            // 하단 버튼 - 운동 기록하기
            recordButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Size.homeVerticalSpacing),
            recordButton.heightAnchor.constraint(equalToConstant: Constants.Size.mainButtonHeight),
            recordButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.horizontalMargin),
            recordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.horizontalMargin),
            
            // 테이블 뷰 - 홈 화면 운동 기록
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: Constants.Size.homeVerticalSpacing),
            tableView.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -Constants.Size.homeVerticalSpacing),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.horizontalMargin),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.horizontalMargin)
        ])
    }
}
