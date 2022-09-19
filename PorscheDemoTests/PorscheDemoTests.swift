//
//  PorscheDemoTests.swift
//  PorscheDemoTests
//
//  Created by Peter Liaw on 9/17/22.
//

import XCTest
@testable import PorscheDemo

class PorscheDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetPhotos() throws {
        let exp = expectation(description: "testGetPhotos")
        let service = UnsplashDataService()
        service.getPhotos(query: "Porsche cars", count: 20) { result in
            switch result {
            case .success(let resp):
                print(resp)
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }

}
