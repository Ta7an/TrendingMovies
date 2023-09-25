//
//  TMMoviesListWireframeTests.swift
//  TrendingMoviesTests
//
//  Created by Mohamed Eltahan on 24/09/2023.
//

import XCTest
@testable import TrendingMovies
import SDWebImage

final class TMMoviesListWireframeTests: XCTestCase {

    var navigationController: UINavigationController!
    var wireframe: TMMoviesListWireframe!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        wireframe = TMMoviesListWireframe()
        wireframe.navigationController = navigationController
    }
    override func tearDown() {
        navigationController = nil
        wireframe = nil
        super.tearDown()
    }
    func testBuildModule() {
        let navigationController = TMMoviesListWireframe.buildModule() as? UINavigationController
        let viewController = navigationController?.viewControllers.first as? TMMoviesListController

        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.presenter)
        XCTAssertNotNil(viewController?.presenter?.interactor)
        XCTAssertNotNil(viewController?.presenter?.wireframe)
    }
    func testNavigateToMovieDetails() {
        // Create a sample movie
        let movie = TMMovie(
            adult: false,
            backdropPath: "",
            genreIds: [1, 2],
            id: 1, originalLanguage: "En",
            originalTitle: "Title",
            overview: "overview",
            popularity: 5,
            posterPath: nil,
            releaseDate: "24-12-2023",
            title: "Title",
            video: false,
            voteAverage: 8,
            voteCount: 300
        )
        // Create a TMMovieUIModel from the TMMovie
        let movieUIModel = TMMovieUIModel(movie: movie)
        // Call the navigation method
        wireframe.navigateToMovieDetails(movieUIModel)
        // Verify that the top view controller on the navigation stack is the detail module
        let topViewController = navigationController.topViewController as? TMMovieDetailsController
        XCTAssertNotNil(topViewController)
    }
}
