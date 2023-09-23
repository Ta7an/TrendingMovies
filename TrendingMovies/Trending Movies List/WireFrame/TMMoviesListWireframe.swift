
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
    
    weak var viewController: UIViewController?
    
}

// MARK: build's Module

extension TMMoviesListWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = TMMoviesListWireframe()
        let nav = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        let view = nav.viewControllers.first as! TMMoviesListController
        let interactor = TMMoviesListInteractor(configService: TMConfigurationService(), movieService: TMMovieService())
        let presenter = TMMoviesListPresenter(view: view, interactor: interactor)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return nav
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "TMMovies", bundle: Bundle.main)
    }

}

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)

        return instantiateViewController(withIdentifier: identifier) as! T
    }

}
