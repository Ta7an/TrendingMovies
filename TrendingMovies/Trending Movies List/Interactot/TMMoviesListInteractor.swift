
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
    
    private var movieService: TMMovieService // Replace with your network service
    var output: TMMoviesListInteractorOutputInterface?

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


    init(movieService: TMMovieService) {
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

