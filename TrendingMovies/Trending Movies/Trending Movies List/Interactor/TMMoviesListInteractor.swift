
//
//  TMMoviesListInteractor.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//  
//

import Foundation

// MARK: TMMoviesListInteractor: BaseInteractor

class TMMoviesListInteractor: TMMoviesListInteractorInputInterface {
    var presenter: TMMoviesListInteractorOutputInterface?
    
    private var configService: TMConfigurationService
    private var movieService: TMMovieService
    private let errorHandler: ErrorHandling

    var output: TMMoviesListInteractorOutputInterface?

    init(configService: TMConfigurationService, movieService: TMMovieService, errorHandler: ErrorHandling) {
        self.configService = configService
        self.movieService = movieService
        self.errorHandler = errorHandler
    }
    
    func fetchConfiguration() {
        configService.fetchConfig { [weak self] result in
            switch result {
            case .success(let config):
                self?.output?.onConfigFetched(config)
            case .failure(let error):
                self?.output?.onError(error)
            }
        }
    }
    
    func fetchMovies(page: Int) {
        movieService.fetchMovies(page: page) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.output?.onMoviesFetched(movies)
            case .failure(let error):
                self?.output?.onError(error)
            }
        }
    }
}

// MARK: TMMoviesListInteractorInputInterface - Output lifecycle Methods

extension TMMoviesListInteractor {
    
    func outputDidLoad() {}
    
    func outputFinished() {
//        disposibles.dispose()
        
    }
    
}

