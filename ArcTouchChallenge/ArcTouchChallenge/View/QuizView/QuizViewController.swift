//
//  QuizViewController.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    let viewModel: QuizViewModel = QuizViewModel()
    
    lazy var quizView: QuizView = {
        let view = QuizView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = quizView
        viewModel.loadQuiz()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.isLoading = { [weak self] loading in
            self?.quizView.isLoading = loading
        }
        
        viewModel.errorLoadingData = { [weak self] erro in
            self?.showAlert("error", message: erro.localizedDescription, button: "Try again", handler: { [weak self] _ in
                self?.viewModel.loadQuiz()
            })
        }
    }

}
