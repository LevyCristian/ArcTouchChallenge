//
//  EndPointTest.swift
//  ArcTouchChallengeTests
//
//  Created by Levy Cristian on 19/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import XCTest
@testable import ArcTouchChallenge

class EndPointTest: XCTestCase {

    var quizEndPoint: QuizApi!
   
    override func setUp() {
        super.setUp()
        quizEndPoint = QuizApi.getQuiz
    }
    
    override func tearDown() {
        super.tearDown()
        quizEndPoint = nil
    }
    
    func testApiAdressIsValid() {
        let apiAdress = "https://codechallenge.arctouch.com/"
        XCTAssertEqual(apiAdress, quizEndPoint.apiAdress)
    }
    
    func testApiAdressIsNotValid() {
        let apiAdress = "www.google.com"
        XCTAssertNotEqual(apiAdress, quizEndPoint?.apiAdress)
    }
    
    func testPathToQuizEndPointIsValid() {
        let path = "https://codechallenge.arctouch.com/quiz/1"
        XCTAssertEqual(path, quizEndPoint.path)

    }
    
    func testPathToPopularMovieEndPointIsNotValid() {
        let path = "www.google.com"
        XCTAssertNotEqual(path, quizEndPoint.path)
    }
}
