//
//  RequestTest.swift
//  ArcTouchChallengeTests
//
//  Created by Levy Cristian on 19/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import XCTest
@testable import ArcTouchChallenge

class RequestTest: XCTestCase {

    var request: Request<QuizApi>!
    var errorInvalidURL: Errors!
    var errorFailRequest: Errors!
    var errorNoInternet: Errors!

    override func setUp() {
        super.setUp()
        request = Request<QuizApi>()
        errorInvalidURL = Errors.invalidURL
        errorFailRequest = Errors.failRequest
        errorNoInternet = Errors.noInternet
    }
  
    override func tearDown() {
        super.tearDown()
        request = nil
        errorInvalidURL = nil
        errorFailRequest = nil
        errorNoInternet = nil
    }
    
    func testRunGetQuizReturnSucess() {
        request.run(QuizApi.getQuiz) { (result: Result<Quiz, Errors>) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail("Element should be decodable by this EndPoint")
            }
        }
    }
    
    func testRunGetQuizReturnFailure() {
        request.run(QuizApi.getQuiz) { (result: Result<Data, Errors>) in
            switch result {
            case .success:
                XCTFail("Element shouldn't be decodable by this EndPoint")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Applicantion cannot request external data")
            }
        }
    }
    
   func testErrorInvalidURLLocalizeDescriptionGetter() {
       XCTAssertEqual(errorInvalidURL.localizedDescription, "Invalid URL")
   }
   
   func testErrorFailRequestLocalizeDescriptionGetter() {
       XCTAssertEqual(errorFailRequest.localizedDescription, "Applicantion cannot request external data")
   }
    
    func testErrorNoInternetLocalizeDescriptionGetter() {
        XCTAssertEqual(errorNoInternet.localizedDescription, "The Internet connection appears to be offline")
    }
}
