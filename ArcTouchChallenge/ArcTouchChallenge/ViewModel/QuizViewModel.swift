//
//  QuizViewModel.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 18/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

class QuizViewModel {
    
    // MARK: - Typealias
    typealias BooleanClosure = ((Bool) -> Void)
    typealias StringClosure = ((String) -> Void)
    typealias ErrorClousure = ((Errors) -> Void)
    
    // MARK: - Binding closures
    var isLoading: BooleanClosure?
    var errorLoadingData: ErrorClousure?
    var updateTitleWithQuestion: StringClosure?
    
    private var answers: [String]
    
    private var question: String  {
        didSet(newValue) {
            updateTitleWithQuestion?(newValue)
        }
    }
    
    init(answers: [String] = [String]()) {
        self.answers = answers
        self.question = ""
    }
    
    func loadQuiz() {
        isLoading?(true)
        QuizRepository.getQuiz { [weak self] (result: Result<Quiz, Errors>) in
            switch result {
            case .success(let quiz):
                self?.isLoading?(false)
                self?.answers = quiz.answer
                self?.question = quiz.question
            case .failure(let erro):
                self?.isLoading?(false)
                self?.errorLoadingData?(erro)
            }
        }
        
    }
    
}
