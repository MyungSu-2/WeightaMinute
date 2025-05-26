//
//  HomeTableViewCell.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/27/25.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    // MARK: - 테이블 뷰 셀 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.body
        label.textColor = Constants.Color.mainText
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [titleLabel].forEach { self.contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        [titleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    // MARK: - 레이블 텍스트 설정
    func configure(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        titleLabel.text = formatter.string(from: date) + " 운동"
    }
}
