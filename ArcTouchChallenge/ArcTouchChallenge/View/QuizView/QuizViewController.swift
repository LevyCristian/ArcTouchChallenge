//
//  QuizViewController.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    lazy var quizView: QuizView = {
        let view = QuizView()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = quizView
        quizView.isLoading = false
    }

}
