//
//  QuizApiEndPoint.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

public enum QuizApi {
    case getQuiz
}

extension QuizApi: EndPointType {
    
    var url: URL {
        return URL(string: self.path)!
    }
    
    var apiAdress: String {
        return "https://codechallenge.arctouch.com/"
    }
    
    var path: String {
        switch self {
        case .getQuiz:
            return apiAdress + "quiz/1"
        }
    }
}
