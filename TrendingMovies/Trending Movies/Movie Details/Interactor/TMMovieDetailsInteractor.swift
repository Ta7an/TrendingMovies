
//
//  TMMovieDetailsInteractor.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//  
//

import Foundation

// MARK: TMMovieDetailsInteractor: BaseInteractor

class TMMovieDetailsInteractor: TMBaseInteractor {
    let configurationService: TMConfigurationService
    
    var output: TMMovieDetailsInteractorOutputInterface?
    
    init(output: TMMovieDetailsInteractorOutputInterface?, configurationService: TMConfigurationService) {
        self.output = output
        self.configurationService = configurationService
    }
}

// MARK: TMMovieDetailsInteractorInputInterface - Output lifecycle Methods

extension TMMovieDetailsInteractor: TMMovieDetailsInteractorInputInterface {
    
    var configData: TMImagesConfig? {
        return configurationService.imagesConfig
    }
    func outputDidLoad() {}
    
    func outputFinished() {

    }
    
}

