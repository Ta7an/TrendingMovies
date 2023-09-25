//
//  TMMoviesListPresenterTests.swift
//  TrendingMoviesTests
//
//  Created by Mohamed Eltahan on 25/09/2023.
//

import XCTest
@testable import TrendingMovies

class TMMoviesListPresenterTests: XCTestCase {
    var presenter: TMMoviesListPresenter!
    var mockView: MockTMMoviesListViewInterface!
    var mockInteractor: MockTMMoviesListInteractorInputInterface!
    var mockWireframe: MockTMMoviesListWireframeInterface!
    var mockErrorHandler: MockErrorHandling!

    override func setUp() {
        super.setUp()
        mockView = MockTMMoviesListViewInterface()
        mockInteractor = MockTMMoviesListInteractorInputInterface()
        mockWireframe = MockTMMoviesListWireframeInterface()
        mockErrorHandler = MockErrorHandling()
        presenter = TMMoviesListPresenter(
            view: mockView,
            interactor: mockInteractor,
            errorHandler: mockErrorHandler
        )
        presenter.wireframe = mockWireframe
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockWireframe = nil
        mockErrorHandler = nil
        presenter = nil
        super.tearDown()
    }

    // Test presentMainLoading and presentMainLoadingComplete methods
    func testPresentMainLoadingAndComplete() {
        presenter.presentMainLoading()
        XCTAssertTrue(mockView.showMainLoadingIndicatorCalled, "showMainLoadingIndicator should be called")
        presenter.presentMainLoadingComplete()
        XCTAssertTrue(mockView.hideMainLoadingIndicatorCalled, "hideMainLoadingIndicator should be called")
    }

    // Test presentBottomLoading and presentBottomLoadingComplete methods
    func testPresentBottomLoadingAndComplete() {
        presenter.presentBottomLoading()
        XCTAssertTrue(mockView.showBottomLoadingIndicatorCalled, "showBottomLoadingIndicator should be called")
        presenter.presentBottomLoadingComplete()
        XCTAssertTrue(mockView.hideBottomLoadingIndicatorCalled, "hideBottomLoadingIndicator should be called")
    }

    // Test fetchMovies method
    func testFetchMovies() {
        presenter.fetchMovies()
        XCTAssertTrue(mockInteractor.fetchMoviesCalled, "fetchMovies on the interactor should be called")
    }

    // Test didSelectMovie method
    func testDidSelectMovie() {
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
        presenter.didSelectMovie(movieUIModel)
        XCTAssertTrue(mockWireframe.navigateToMovieDetailsCalled, "navigateToMovieDetails on the wireframe should be called")
    }

    // Add more tests for other presenter methods as needed
}

class MockTMMoviesListViewInterface: TMMoviesListViewInterface {
    var presenter: TrendingMovies.TMMoviesListPresenterInterface?
    var showMainLoadingIndicatorCalled = false
    var hideMainLoadingIndicatorCalled = false
    var showBottomLoadingIndicatorCalled = false
    var hideBottomLoadingIndicatorCalled = false
    var updateMoviesListCalled = false
    var updateTMDBImagesConfigCalled = false

    func showMainLoadingIndicator() {
        showMainLoadingIndicatorCalled = true
    }

    func hideMainLoadingIndicator() {
        hideMainLoadingIndicatorCalled = true
    }

    func showBottomLoadingIndicator() {
        showBottomLoadingIndicatorCalled = true
    }

    func hideBottomLoadingIndicator() {
        hideBottomLoadingIndicatorCalled = true
    }

    func updateMoviesList(_ movies: [TMMovieUIModel]) {
        updateMoviesListCalled = true
    }

    func updateTMDBImagesConfig(_ config: TMImagesConfig) {
        updateTMDBImagesConfigCalled = true
    }
}

class MockTMMoviesListInteractorInputInterface: TMMoviesListInteractorInputInterface {
    var output: TrendingMovies.TMMoviesListInteractorOutputInterface?
    func outputFinished() {}
    var fetchConfigurationCalled = false
    var fetchMoviesCalled = false

    func fetchConfiguration() {
        fetchConfigurationCalled = true
    }

    func fetchMovies(page: Int) {
        fetchMoviesCalled = true
    }
}

class MockTMMoviesListWireframeInterface: TMMoviesListWireframeInterface {
    static func buildModule() -> UIViewController {
        return UIViewController()
    }
    var navigateToMovieDetailsCalled = false

    func navigateToMovieDetails(_ movie: TMMovieUIModel) {
        navigateToMovieDetailsCalled = true
    }
}

class MockErrorHandling: ErrorHandling {
    var handleAPIErrorCalled = false

    func handleAPIError(_ error: String) {
        handleAPIErrorCalled = true
    }
}
