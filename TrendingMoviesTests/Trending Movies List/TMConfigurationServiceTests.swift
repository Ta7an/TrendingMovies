//
//  TMConfigurationServiceTests.swift
//  TrendingMoviesTests
//
//  Created by Mohamed Eltahan on 24/09/2023.
//

import XCTest
@testable import TrendingMovies

final class TMConfigurationServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchConfig() {
        let configService = TMConfigurationService.shared
        let expectation = self.expectation(description: "Config fetched successfully")
        configService.fetchConfig { result in
            switch result {
            case .success(let config):
                XCTAssertNotNil(config)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error fetching config: \(error)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
