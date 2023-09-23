//
//  TMConfigurationService.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//

import Alamofire
import Foundation

class TMConfigurationService: TMConfigurationServiceInterface {
    
    func fetchConfig(completion: @escaping (Result<TMConfigModel, Error>) -> Void) {
        let url = "\(TMDBApiInfo.baseURL)/configuration"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": TMDBApiInfo.apiKey
        ]
        
        let request = AF.request(url, method: .get, headers: headers)
            .validate()

        request.responseDecodable(of: TMConfigModel.self) { response in
            switch response.result {
            case .success(let configuration):
                completion(.success(configuration))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
