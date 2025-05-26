//
//  HomeCalendarCell.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/26/25.
//

import UIKit

final class HomeCalendarCell: UICollectionViewCell {
    // MARK: - 날짜 표시 레이블
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.calendarDates
        label.textColor = Constants.Color.calendarText
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - 운동 기록 표시 점
    private let recordDisplay: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.Size.calendarRecordDotSpacing
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 셀 설정 및 오토레이아웃 설정
    private func setupCell() {
        [dateLabel, recordDisplay].forEach { self.contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        [dateLabel, recordDisplay].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            recordDisplay.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            recordDisplay.heightAnchor.constraint(equalToConstant: Constants.Size.calendarRecordDotWidth),
            recordDisplay.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    // 날짜와 기록 수를 이용해 셀을 초기화하는 메서드
    func configure(date: Int, dateColor: UIColor, recordCount: Int) {
        // 유효한 날짜 값일 경우 날짜 레이블 설정
        if date == 0 {
            dateLabel.text = ""
        } else {
            dateLabel.text = "\(date)"
        }
        
        // 요일에 따른 날짜 색상 적용
        dateLabel.textColor = dateColor
        
        // 셀에 남아 있는 기록 표시 초기화
        recordDisplay.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 기록 수만큼 점 표시 추가
        for count in 0 ..< recordCount {
            let dot = UIView()
            dot.layer.cornerRadius = 2
            switch count {
            case 0:
                dot.backgroundColor = Constants.Color.calendarRecordDotColor[0]
            case 1:
                dot.backgroundColor = Constants.Color.calendarRecordDotColor[1]
            default:
                dot.backgroundColor = Constants.Color.calendarRecordDotColor[2]
            }
            
            dot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: Constants.Size.calendarRecordDotWidth),
                dot.heightAnchor.constraint(equalToConstant: Constants.Size.calendarRecordDotWidth)
            ])
            
            recordDisplay.addArrangedSubview(dot)
        }
    }
}
