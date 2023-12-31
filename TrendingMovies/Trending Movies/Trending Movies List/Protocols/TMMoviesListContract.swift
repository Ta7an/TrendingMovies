//
//  TMMoviesListContract.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//  
//

import Foundation
import UIKit

protocol TMMoviesListViewInterface: TMBaseViewController {
    var presenter: TMMoviesListPresenterInterface? { get set }
    func updateMoviesList(_ movies: [TMMovieUIModel])
    func updateTMDBImagesConfig(_ config: TMImagesConfig)

    // Loading indicators..
    func showMainLoadingIndicator()
    func hideMainLoadingIndicator()
    func showBottomLoadingIndicator()
    func hideBottomLoadingIndicator()
}

protocol TMMoviesListPresenterInterface: TMBasePresenter {
    var view: TMMoviesListViewInterface? { get set }
    var interactor: TMMoviesListInteractorInputInterface { get set }
    var wireframe: TMMoviesListWireframeInterface? { get set }
    func fetchMovies()
    func didSelectMovie(_ movie: TMMovieUIModel)
}

protocol TMMoviesListInteractorInputInterface: TMBaseInteractor {
    var output: TMMoviesListInteractorOutputInterface? { get set }
    func fetchConfiguration()
    func fetchMovies(page: Int)

    func outputFinished()
}

protocol TMMoviesListInteractorOutputInterface: AnyObject {
    func onConfigFetched(_ config: TMConfigModel)
    func onMoviesFetched(_ movies: [TMMovie])
    func onError(_ error: Error)
}

protocol TMConfigurationServiceInterface {
    func fetchConfig(completion: @escaping (Result<TMConfigModel, Error>) -> Void)
}

protocol TMMovieServiceInterface {
    func fetchMovies(page: Int, completion: @escaping (Result<[TMMovie], Error>) -> Void)
}

protocol TMMoviesListWireframeInterface: TMBaseWireFrame {
    static func buildModule() -> UIViewController
    func navigateToMovieDetails(_ movie: TMMovieUIModel)
}
