//
//  Quiz.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

// MARK: - Quiz
struct Quiz: Codable {
    let question: String
    let answer: [String]
}
