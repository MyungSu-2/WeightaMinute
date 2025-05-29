//
//  ExerciseListView.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/29/25.
//

import UIKit

final class ExerciseListView: UIView {
    // MARK: - UI 객체 선언
    // 뒤로 가기 버튼
    let backToHomeButton: UIButton = {
        let button = UIButton()
        
        
        
        return button
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
        
    }
    
    private func setupConstraints() {
        
    }

}
