//
//  Repository.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation
/**
    Repository pattern protocol where contains every remote data information case to be implemented
*/
protocol ArcRemoteData {
    static func getQuiz(completion: @escaping (Result<Quiz, Errors>) -> Void)
}
/**
    Repository struct implementation where contains every data manipulation fom Remote our local
*/
public struct QuizRepository: ArcRemoteData {

    private init() {}
    /**
        Get curre quiz from remote
        - parameter Completion: A completion of `Result<Quiz, Errors>` that sould be implemented for each case
    */
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
