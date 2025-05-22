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
        setupTableView()
        setupActions()
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
