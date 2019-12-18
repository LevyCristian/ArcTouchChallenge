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
    typealias StringClosure = ((String?) -> Void)
    typealias ErrorClousure = ((Errors) -> Void)
    
    // MARK: - Binding closures
    var isLoading: BooleanClosure?
    var errorLoadingData: ErrorClousure?
    var updateTitleWithQuestion: StringClosure?
    var updateUIWithCurrentTimer: StringClosure?
    var updatedUIWitCurrenthCounterValue: StringClosure?
    var didFinishQuiz: BooleanClosure?
    
    // MARK: - Variables
    private var quizResponse: Quiz?
    private var numberOfHits: Int = 0
    private var cellViewModels: [KeywordCellViewModel] = []
    private var quizTimer: TimerManager = TimerManager()

    private var numberOfAnswers: Int  {
        return quizResponse?.answer.count ?? 0
    }
    
    private var hits: [String] {
        didSet(newValue) {
            let hitsReverseOrder = hits.reversed()
            cellViewModels = hitsReverseOrder.map { (keyword) in
                KeywordCellViewModel(keyword: keyword)
            }
        }
    }
    
    var buttonTitle: String? {
        return quizTimer.timer == nil ? "Start" : "Reset"
    }
    
    var numberOfRows: Int {
        return cellViewModels.count
    }
    
    var countLabel: String? {
        return String(format:"%02i/%02i", numberOfHits, numberOfAnswers)

    }

    private var question: String  {
        willSet(newValue) {
            updateTitleWithQuestion?(newValue)
        }
    }
    
    init() {
        self.question = ""
        self.hits = []
        setupTimer()
    }
    
    func loadQuiz() {
        isLoading?(true)
        QuizRepository.getQuiz { [weak self] (result: Result<Quiz, Errors>) in
            switch result {
            case .success(let quiz):
                self?.isLoading?(false)
                self?.question = quiz.question
                self?.quizResponse = quiz
                self?.updateUIWithCurrentTimer?("5:00")
                self?.updatedUIWitCurrenthCounterValue?(self?.countLabel)
                
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
            checkHit(hit: text)
        }
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> KeywordCellViewModel? {
        return cellViewModels[indexPath.row]
    }
    
    private func checkHit(hit: String) {
        let hit = hit.lowercased()
        if let awnsers = quizResponse?.answer, awnsers.contains(hit), !hits.contains(hit) {
            self.hits.append(hit)
            self.numberOfHits+=1
            self.updatedUIWitCurrenthCounterValue?(self.countLabel)

            if numberOfHits == numberOfAnswers {
                didFinishQuiz?(true)
            }
        }
    }
}
