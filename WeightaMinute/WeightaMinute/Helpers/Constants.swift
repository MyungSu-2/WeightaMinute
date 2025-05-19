//
//  Constants.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/19/25.
//

import UIKit

// MARK: - 프로젝트 상수 관리
public struct Constants {
    // 색상
    struct Color {
        // 배경 색상
        static let appBackground = UIColor.white
        static let buttonBackground = UIColor.black
        static let contentsBackground = UIColor.lightGray
        static let textFieldBackground = UIColor.gray
        
        // 선 색상
        static let calendarBorder = UIColor.black
        static let separator = UIColor.lightGray
        
        // 글자 색상
        static let mainText = UIColor.black
        static let secondaryText = UIColor.lightGray
        static let buttonText = UIColor.white
        
        // 아이콘 색상
        static let addIcon = UIColor.green
        static let deleteIcon = UIColor.red
        static let trashIcon = UIColor.black
        
        private init() {}
    }
    
    // 폰트
    struct Font {
        // 텍스트 글꼴
        static let title = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let body = UIFont.systemFont(ofSize: 16)
        static let small = UIFont.systemFont(ofSize: 14)
        
        // 버튼 글꼴
        static let button = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let smallButton = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        private init() {}
    }
    
    // 크기
    struct Size {
        // 둥근 모서리
        static let cornerRadius: CGFloat = 10
        static let smallcornerRadius: CGFloat = 8
        
        // 버튼 높이
        static let managementButtonHeight: CGFloat = 40
        static let mainButtonHeight: CGFloat = 50
        
        // 간격
        static let blockSpacing: CGFloat = 4
        static let horizontalMargin: CGFloat = 24
        static let homeTopMargin: CGFloat = 36
        static let homeVerticalSpacing: CGFloat = 16
        
        // 캘린더 높이
        static let calendarHeight: CGFloat = 350
        
        // 선 굵기
        static let borderWidth: CGFloat = 1.0
        static let separatorHeight: CGFloat = 1.0
        
        private init() {}
    }
    
    // 텍스트
    struct Message {
        static let emptyWorkoutRecord = "운동 기록이 없습니다."
        static let emptyExercises = "기록할 운동을 추가하세요."
        static let emptyFeedbackList = "남긴 피드백이 없습니다."
        static let emptyExerciseList = "운동을 추가하세요."
        
        private init() {}
    }
    
    private init() {}
}
