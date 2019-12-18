//
//  QuizViewModel.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 18/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizViewModel {
    
    // MARK: - Typealias
    typealias BooleanClosure = ((Bool) -> Void)
    typealias StringClosure = ((String) -> Void)
    typealias ErrorClousure = ((Errors) -> Void)
    typealias CurrentTimeClosure = ((String) -> Void)
    
    // MARK: - Binding closures
    var isLoading: BooleanClosure?
    var errorLoadingData: ErrorClousure?
    var updateTitleWithQuestion: StringClosure?
    
    // MARK: - UI Bindings
    var updateUIWithCurrentTimer: CurrentTimeClosure?
    
    // MARK: - Variables
    private var answers: [String]
    private var quizTimer: TimerManager = TimerManager()
    
    public var buttonTitle: String? {
        return quizTimer.timer == nil ? "Start" : "Reset"
    }
    private var question: String  {
        willSet(newValue) {
            updateTitleWithQuestion?(newValue)
        }
    }
    
    init(answers: [String] = [String]()) {
        self.answers = answers
        self.question = ""
        setupTimer()
    }
    
    func loadQuiz() {
        isLoading?(true)
        QuizRepository.getQuiz { [weak self] (result: Result<Quiz, Errors>) in
            switch result {
            case .success(let quiz):
                self?.isLoading?(false)
                self?.answers = quiz.answer
                self?.question = quiz.question
                self?.updateUIWithCurrentTimer?("5:00")
            case .failure(let erro):
                self?.isLoading?(false)
                self?.errorLoadingData?(erro)
            }
        }
    }
    
    private func setupTimer() {
        quizTimer.updatedTimerValue = { [unowned self] timerFormated in
            self.updateUIWithCurrentTimer?(timerFormated)
        }
    }
    
    @objc func didTapQuizButton(_ button: UIButton) {
        if quizTimer.timer == nil {
            quizTimer.startTimer()
        } else {
            quizTimer.invalidateTimer()
            quizTimer.resetCounterAndTimer()
        }
    }
}
