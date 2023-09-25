//
//  TMMovieDetailsContract.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//  
//

import Foundation
import UIKit

protocol TMMovieDetailsViewInterface: TMBaseViewController {
    var presenter: TMMovieDetailsPresenterInterface? { get set }
    func setupUI(with movie: TMMovieUIModel)
}

protocol TMMovieDetailsPresenterInterface: TMBasePresenter {
    var view: TMMovieDetailsViewInterface? { get set }
    var interactor: TMMovieDetailsInteractorInputInterface? { get set }
    var wireframe: TMMovieDetailsWireframeInterface? { get set }
    var moviePosterURL: URL { get }
}

protocol TMMovieDetailsInteractorInputInterface: TMBaseInteractor {
    var output: TMMovieDetailsInteractorOutputInterface? { get set }
    var configData: TMImagesConfig? { get }
}

protocol TMMovieDetailsInteractorOutputInterface: AnyObject {
}

protocol TMMovieDetailsWireframeInterface: TMBaseWireFrame {
    static func buildModule(_ movie: TMMovieUIModel, configurationService: TMConfigurationServiceInterface) -> UIViewController
}
