
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
}

protocol TMMoviesListPresenterInterface: TMBasePresenter {
    var view: TMMoviesListViewInterface? { get set }
    var interactor: TMMoviesListInteractorInputInterface { get set }
    var wireframe: TMMoviesListWireframeInterface? { get set }
    
    #warning("To be implemented while performing push to detail page..")
//    func showPostDetail(forPost post: PostModel)
    func fetchMovies()

}

protocol TMMoviesListInteractorInputInterface: TMBaseInteractor {
    var output: TMMoviesListInteractorOutputInterface? { get set }
    func fetchMovies(page: Int)

    func outputFinished()
}

protocol TMMoviesListInteractorOutputInterface: AnyObject {
    func onMoviesFetched(_ movies: [TMMovie])
}

protocol TMMovieServiceInterface {
    func fetchMovies(page: Int, completion: @escaping (Result<[TMMovie], Error>) -> Void)
}

protocol TMMoviesListWireframeInterface: TMBaseWireFrame {
    
}
