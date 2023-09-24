//
//  TMConfigurationService.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//

import Alamofire
import Foundation

class TMConfigurationService: TMConfigurationServiceInterface {
    static let shared = TMConfigurationService()

    private var configData: TMConfigModel?

    func fetchConfig(completion: @escaping (Result<TMConfigModel, Error>) -> Void) {
        let url = "\(TMDBApiInfo.baseURL)/configuration"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": TMDBApiInfo.apiKey
        ]
        
        let request = AF.request(url, method: .get, headers: headers)
            .validate()

        request.responseDecodable(of: TMConfigModel.self) { [weak self] response in
            switch response.result {
            case .success(let configuration):
                self?.configData = configuration
                completion(.success(configuration))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    var imagesConfig: TMImagesConfig? {
        configData?.images
    }
}
