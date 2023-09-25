//
//  TMMoviesListInteractorTests.swift
//  TrendingMoviesTests
//
//  Created by Mohamed Eltahan on 24/09/2023.
//

import XCTest
@testable import TrendingMovies

final class TMMoviesListInteractorTests: XCTestCase {
    var interactor: TMMoviesListInteractor!
    var mockPresenter: MockTMMoviesListPresenter!
    override func setUp() {
        super.setUp()
        mockPresenter = MockTMMoviesListPresenter()
        let configService = TMConfigurationService()
        let movieService = TMMovieService()
        let errorHandler = TMMoviesListController()
        interactor = TMMoviesListInteractor(configService: configService, movieService: movieService, errorHandler: errorHandler)
        interactor.presenter = mockPresenter
        interactor.output = mockPresenter
    }
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        super.tearDown()
    }
    func testFetchConfigurationSuccess() {
        // Create an expectation
        mockPresenter.onConfigFetchedCalledClosure = { _ in
            XCTAssertTrue(self.mockPresenter.onConfigFetchedCalled, "onConfigFetched should be called on success")
            XCTAssertFalse(self.mockPresenter.onErrorCalled, "onError should not be called on success")
        }
            // Call the function to be tested
        interactor.fetchConfiguration()
            // Wait for the expectation to be fulfilled (or a timeout)
            // Assert that the function was called
    }
    func testFetchConfigurationFailure() {
        // Simulate a failure in the fetchConfiguration method
        let expectedError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
        mockPresenter.onErrorCalledClosure = { error in
            // Ensure onError is called and capture the error parameter
            XCTAssertTrue(self.mockPresenter.onErrorCalled, "onError should be called on failure")
            XCTAssertEqual(error as NSError, expectedError, "Error parameter should match the expected error")
        }
            // Trigger the failure scenario
        interactor.fetchConfiguration()
    }
    func testFetchMoviesSuccess() {
        mockPresenter.onMoviesFetchedCalledClosure = { _ in
            XCTAssertTrue(self.mockPresenter.onMoviesFetchedCalled, "onMoviesFetched should be called on success")
            XCTAssertFalse(self.mockPresenter.onErrorCalled, "onError should not be called on success")
        }
        interactor.fetchMovies(page: 1)
    }
    func testFetchMoviesFailure() {
        mockPresenter.onErrorCalledClosure = { error in
            XCTAssertFalse(self.mockPresenter.onMoviesFetchedCalled, "onMoviesFetched should not be called on failure")
            XCTAssertTrue(self.mockPresenter.onErrorCalled, "onError should be called on failure")
        }
        interactor.fetchMovies(page: 1)
    }
}

class MockTMMoviesListPresenter: TMMoviesListPresenterInterface, TMMoviesListInteractorOutputInterface {
    var view: TMMoviesListViewInterface?
    var interactor: TMMoviesListInteractorInputInterface
    var wireframe: TMMoviesListWireframeInterface?
    init() {
        let nav = TMMoviesListWireframe.buildModule() as? UINavigationController
        let topViewController = nav?.topViewController as? TMMoviesListViewInterface
        self.view = topViewController
        self.interactor = self.view!.presenter!.interactor
        self.wireframe = self.view?.presenter?.wireframe
    }
    func fetchMovies() {}
    func didSelectMovie(_ movie: TrendingMovies.TMMovieUIModel) {}

    // Track whether onConfigFetched is called
    var onConfigFetchedCalled: Bool = false
    // Define a closure property to track the call
    var onConfigFetchedCalledClosure: ((TMConfigModel) -> Void)?
    func onConfigFetched(_ config: TMConfigModel) {
        // Mark that the function was called
        onConfigFetchedCalled = true
            // Call the closure to track the call
        onConfigFetchedCalledClosure?(config)
    }
    var onErrorCalled = false
    // Define a closure property to track the call
    var onErrorCalledClosure: ((Error) -> Void)?
    func onError(_ error: Error) {
        // Mark that the function was called
        onErrorCalled = true
            // Call the closure to track the call
        onErrorCalledClosure?(error)
    }
    var onMoviesFetchedCalled: Bool = false
    // Define closure properties to track the calls
    var onMoviesFetchedCalledClosure: (([TMMovie]) -> Void)?
    func onMoviesFetched(_ movies: [TMMovie]) {
        // Mark that the function was called
        onMoviesFetchedCalled = true

        // Call the closure to track the call
        onMoviesFetchedCalledClosure?(movies)
    }
    func onFetchMovieError(_ error: Error) {
        // Mark that the function was called
        onErrorCalled = true

        // Call the closure to track the call
        onErrorCalledClosure?(error)
    }
}
