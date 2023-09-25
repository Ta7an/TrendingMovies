//
//  TMMoviesListWireframe.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//  
//

import UIKit

// MARK: TMMoviesListWireframe: TMMoviesListWireframeInterface

class TMMoviesListWireframe: TMMoviesListWireframeInterface {
    weak var navigationController: UINavigationController?
}

// MARK: build's Module

extension TMMoviesListWireframe {
    static func buildModule() -> UIViewController {
        let wireframe = TMMoviesListWireframe()
        wireframe.navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as? UINavigationController
        guard let view = wireframe.navigationController?.viewControllers.first as? TMMoviesListController else { return UIViewController() }
        let interactor = TMMoviesListInteractor(configService: TMConfigurationService.shared, movieService: TMMovieService(), errorHandler: view)
        let presenter = TMMoviesListPresenter(view: view, interactor: interactor, errorHandler: view)
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.output = presenter
        return wireframe.navigationController ?? UIViewController()
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "TMMovies", bundle: Bundle.main)
    }
    func navigateToMovieDetails(_ movie: TMMovieUIModel) {
        // Create and configure the Detail Module
        let detailModule = TMMovieDetailsWireframe.buildModule(movie, configurationService: TMConfigurationService.shared)
        // Push the Detail View Controller onto the navigation stack
        navigationController?.pushViewController(detailModule, animated: true)
    }
}
