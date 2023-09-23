
//
//  TMMoviesListPresenter.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//  
//

import Foundation

// MARK: TMMoviesListPresenter

class TMMoviesListPresenter: TMMoviesListPresenterInterface {
    
    var view: TMMoviesListViewInterface?
    var interactor: TMMoviesListInteractorInputInterface
    var wireframe: TMMoviesListWireframeInterface?
    private let errorHandler: ErrorHandling

    private var currentPage = 1

    init(view: TMMoviesListViewInterface?, interactor: TMMoviesListInteractorInputInterface, errorHandler: ErrorHandling) {
        self.view = view
        self.interactor = interactor
        self.errorHandler = errorHandler
    }
    
    func presentMainLoading() {
        view?.showMainLoadingIndicator()
    }

    func presentMainLoadingComplete() {
        view?.hideMainLoadingIndicator()
    }

    func presentBottomLoading() {
        view?.showBottomLoadingIndicator()
    }

    func presentBottomLoadingComplete() {
        view?.hideBottomLoadingIndicator()
    }
}

// MARK: HomePresenterInterface - Lifecycle methods

extension TMMoviesListPresenter {
    
    func fetchMovies() {
        switch currentPage {
        case 1:
            presentMainLoading()
        default:
            presentBottomLoading()
        }
        interactor.fetchMovies(page: currentPage)
    }

    func viewDidLoad() {
        interactor.fetchConfiguration()
        fetchMovies()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension TMMoviesListPresenter: TMMoviesListInteractorOutputInterface {
    func transformMoviesToUIModels(movies: [TMMovie]) -> [TMMovieUIModel] {
        var movieUIModels = [TMMovieUIModel]()
        for movie in movies {
            let movieUIModel = TMMovieUIModel(movie: movie)
            movieUIModels.append(movieUIModel)
        }
        return movieUIModels
    }

    func onMoviesFetched(_ movies: [TMMovie]) {
        presentMainLoadingComplete()
        presentBottomLoadingComplete()
        
        let movieUIModels = transformMoviesToUIModels(movies: movies)
        view?.updateMoviesList(movieUIModels)
        currentPage += 1
    }
    
    func onConfigFetched(_ config: TMConfigModel) {
        view?.updateTMDBImagesConfig(config.images)
    }
    
    func onError(_ error: Error) {
        presentMainLoadingComplete()
        presentBottomLoadingComplete()

        errorHandler.handleAPIError(error.localizedDescription)
    }

}
