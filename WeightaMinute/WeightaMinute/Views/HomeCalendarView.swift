//
//  HomeCalendarView.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/26/25.
//

import UIKit

final class HomeCalendarView: UIView {
    // MARK: - 달력 헤더 선언
    // 연도 및 월 표시 레이블
    let calendarMonthLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.calendarMonth
        label.textColor = Constants.Color.calendarText
        label.textAlignment = .center
        return label
    }()
    
    // 이전 달 버튼
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: Constants.Font.calendarMonth.pointSize, weight: .bold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        
        button.setImage(image, for: .normal)
        button.tintColor = Constants.Color.calendarText
        button.backgroundColor = .clear
        return button
    }()
    
    // 다음 달 버튼
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: Constants.Font.calendarMonth.pointSize, weight: .bold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        
        button.setImage(image, for: .normal)
        button.tintColor = Constants.Color.calendarText
        button.backgroundColor = .clear
        return button
    }()
    
    // 표시 월 변경 버튼 스택 뷰
    private lazy var calendarMonthButton: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prevButton, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    // MARK: - 달력 요일 표시
    private let calendarWeekdays: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        guard let weekdaysArray = formatter.shortWeekdaySymbols else { return stackView }
        
        for day in weekdaysArray {
            let label = UILabel()
            label.text = day
            label.font = Constants.Font.calendarWeekdays
            label.textColor = day == "일" ? Constants.Color.calendarSunday : (day == "토" ? Constants.Color.calendarSaturday : Constants.Color.calendarText)
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        
        return stackView
    }()
    
    // MARK: - 달력 컬렉션 뷰
    let calendarBody: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 하위 뷰 및 오토레이아웃 설정
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [calendarMonthLabel, calendarMonthButton, calendarWeekdays, calendarBody].forEach { addSubview($0) }
    }
    
    // MARK: - 오토레이아웃 설정
    private func setupConstraints() {
        [calendarMonthLabel, calendarMonthButton, calendarWeekdays, calendarBody].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            // 현재 월 표시 레이블
            calendarMonthLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.Size.calendarSpacing),
            calendarMonthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.calendarMargin * 3),
            calendarMonthLabel.heightAnchor.constraint(equalToConstant: Constants.Size.calendarContentHeight),
            
            // 현재 월 변경 버튼 스택 뷰
            calendarMonthButton.topAnchor.constraint(equalTo: calendarMonthLabel.topAnchor),
            calendarMonthButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3 * Constants.Size.calendarMargin),
            calendarMonthButton.heightAnchor.constraint(equalToConstant: Constants.Size.calendarContentHeight),
            
            // 요일 표시 스택 뷰
            calendarWeekdays.topAnchor.constraint(equalTo: calendarMonthLabel.bottomAnchor, constant: Constants.Size.calendarSpacing),
            calendarWeekdays.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.calendarMargin),
            calendarWeekdays.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.calendarMargin),
            calendarWeekdays.heightAnchor.constraint(equalToConstant: Constants.Size.calendarContentHeight),
            
            // 달력 날짜 컬렉션 뷰
            calendarBody.topAnchor.constraint(equalTo: calendarWeekdays.bottomAnchor, constant: Constants.Size.calendarMargin),
            calendarBody.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.Size.calendarMargin),
            calendarBody.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.Size.calendarMargin),
            calendarBody.heightAnchor.constraint(equalToConstant: Constants.Size.calendarBodyHeight)
        ])
    }
}
