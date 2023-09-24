
//
//  TMMovieDetailsPresenter.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//  
//

import Foundation

// MARK: TMMovieDetailsPresenter

class TMMovieDetailsPresenter {
    
    var view: TMMovieDetailsViewInterface?
    var interactor: TMMovieDetailsInteractorInputInterface?
    var wireframe: TMMovieDetailsWireframeInterface?
    
    var movie: TMMovieUIModel
    
    init(view: TMMovieDetailsViewInterface?, movie: TMMovieUIModel) {
        self.view = view
        self.movie = movie
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension TMMovieDetailsPresenter: TMMovieDetailsPresenterInterface {
    
    var moviePosterURL: URL {
        let config = interactor?.configData
        return movie.posterURL(using: config, largePosterSize: true)
    }
    
    func viewDidLoad() {
        self.view?.setupUI(with: movie)
    }
    
    func viewDidDisappear(_ animated: Bool) {
//        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension TMMovieDetailsPresenter: TMMovieDetailsInteractorOutputInterface {
    
}
