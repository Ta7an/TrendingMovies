//
//  TMMovieServiceTests.swift
//  TrendingMoviesTests
//
//  Created by Mohamed Eltahan on 24/09/2023.
//

import XCTest
@testable import TrendingMovies

final class TMMovieServiceTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testFetchMovies() {
        let movieService = TMMovieService()
            let expectation = self.expectation(description: "Movies fetched successfully")
            movieService.fetchMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error fetching movies: \(error)")
            }
        }
            waitForExpectations(timeout: 5, handler: nil)
    }
}
