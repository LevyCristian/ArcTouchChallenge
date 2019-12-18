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
        
        quizView.footerView.quizButton.addTarget(viewModel, action: #selector(viewModel.didTapQuizButton), for: .touchUpInside)
        
        viewModel.isLoading = { [weak self] loading in
            self?.quizView.isLoading = loading
        }
        
        viewModel.errorLoadingData = { [weak self] erro in
            self?.showAlert("error", message: erro.localizedDescription, button: "Try again", handler: { [weak self] _ in
                self?.viewModel.loadQuiz()
            })
        }
        
        viewModel.updateTitleWithQuestion = { [weak self] question in
            self?.quizView.titleLabel.text = question
        }
        
        //Timer Bidings
        viewModel.updateUIWithCurrentTimer = { [weak self] timer in
            self?.quizView.footerView.timerLabel.text = timer
            self?.quizView.footerView.quizButton.title = self?.viewModel.buttonTitle
        }
        
        viewModel.didFinishQuiz = { [weak self] isWinner in
            
            if isWinner {
                
            } else {
                self?.showAlert("Time finished",
                                message: "Sorry, time is up! You got \(1) out of \(10) answers.", button: "Try Again", handler:
                    { [weak self] (_) in
                        self?.viewModel.didTapQuizButton()
                })
            }
            
        }
        
    }

}
