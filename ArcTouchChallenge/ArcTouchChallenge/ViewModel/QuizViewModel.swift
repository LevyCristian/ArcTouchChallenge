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
    var updateUIWithCurrentTimer: CurrentTimeClosure?
    var didFinishQuiz: BooleanClosure?
    
    // MARK: - Variables
    private var numberOfHits: Int = 0
    private var numberOfAnswers: Int = 0
    private var cellViewModels: [KeywordCellViewModel] = []
    
    private var quizTimer: TimerManager = TimerManager()
    
    var buttonTitle: String? {
        return quizTimer.timer == nil ? "Start" : "Reset"
    }
    
    var numberOfRows: Int {
        return cellViewModels.count
    }
    
//    var countLabel: String? {
//        return quizTimer.timer == nil ? "Start" : "Reset"
//    } fazer a label de hits
//
    private var question: String  {
        willSet(newValue) {
            updateTitleWithQuestion?(newValue)
        }
    }
    
    init() {
        self.question = ""
        setupTimer()
    }
    
    func loadQuiz() {
        isLoading?(true)
        QuizRepository.getQuiz { [weak self] (result: Result<Quiz, Errors>) in
            switch result {
            case .success(let quiz):
                self?.isLoading?(false)
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
        
        quizTimer.didFinishQuiz = { [weak self] result in
            self?.didTapQuizButton()
            self?.didFinishQuiz?(result)
        }
    }
    
    @objc func didTapQuizButton() {
        if quizTimer.timer == nil {
            quizTimer.startTimer()
        } else {
            quizTimer.invalidateTimer()
            quizTimer.resetCounterAndTimer()
        }
    }
    
    @objc func textFieldDidChange(_ textField : UITextField) {
        if let text = textField.text, quizTimer.timer != nil {
            
        }
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> KeywordCellViewModel? {
        return cellViewModels[indexPath.row]
    }
}
