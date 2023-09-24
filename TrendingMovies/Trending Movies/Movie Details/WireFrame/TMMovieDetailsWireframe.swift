
//
//  TMMovieDetailsWireframe.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//  
//

import UIKit

// MARK: TMMovieDetailsWireframe: TMMovieDetailsWireframeInterface

class TMMovieDetailsWireframe: TMMovieDetailsWireframeInterface {
    weak var viewController: UIViewController?
}

// MARK: build's Module

extension TMMovieDetailsWireframe {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "TMMovieDetails", bundle: Bundle.main)
    }
    
    static func buildModule(_ movie: TMMovieUIModel, configurationService: TMConfigurationServiceInterface) -> UIViewController {
        let wireframe = TMMovieDetailsWireframe()
        let view = storyboard.instantiateViewController(ofType: TMMovieDetailsController.self)
        let presenter = TMMovieDetailsPresenter(view: view, movie: movie)
        let interactor = TMMovieDetailsInteractor(output: presenter, configurationService: TMConfigurationService.shared)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view
    }
}


