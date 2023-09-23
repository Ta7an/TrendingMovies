
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
    
    var output: TMMoviesListInteractorOutputInterface?

    func fetchConfiguration() {
        configService.fetchConfig { [weak self] result in
            switch result {
            case .success(let config):
                self?.output?.onConfigFetched(config)
            case .failure(let error):
//                self?.output?.onError(error)
                break
            }
        }
    }
    
    func fetchMovies(page: Int) {
        movieService.fetchMovies(page: page) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.output?.onMoviesFetched(movies)
            case .failure(let error):
//                self?.output?.onError(error)
                break
            }
        }
    }


    init(configService: TMConfigurationService, movieService: TMMovieService) {
        self.configService = configService
        self.movieService = movieService
    }
}

// MARK: TMMoviesListInteractorInputInterface - Output lifecycle Methods

extension TMMoviesListInteractor {
    
    func outputDidLoad() {}
    
    func outputFinished() {
//        disposibles.dispose()
        
        self.output = nil
    }
    
}

