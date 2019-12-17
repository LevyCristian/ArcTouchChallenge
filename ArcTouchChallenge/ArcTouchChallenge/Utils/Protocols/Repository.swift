//
//  Repository.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

protocol ArcRemoteData {
    static func getQuiz(completion: @escaping (Result<Quiz, Errors>) -> Void)
}

public struct MovieRepository: ArcRemoteData {

    private init() {}
    
    static func getQuiz(completion: @escaping (Result<Quiz, Errors>) -> Void) {
        let request = Request<QuizApi>()
        request.run(QuizApi.getQuiz) { (result: Result<Quiz, Errors>) in
            switch result {
            case .success(let quiz):
                completion(.success(quiz))
            case .failure(let erro):
                completion(.failure(erro))
            }
        }
    }
}
