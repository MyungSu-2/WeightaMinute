//
//  ExerciseListViewController.swift
//  WeightaMinute
//
//  Created by 최명수 on 5/29/25.
//

import UIKit

class ExerciseListViewController: UIViewController {

    private let exerciseListView = ExerciseListView()
    
    override func loadView() {
        view = exerciseListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
