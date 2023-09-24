//
//  TMMovieService.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 14/09/2023.
//

import Alamofire
import Foundation

class TMMovieService: TMMovieServiceInterface {
    
    func fetchMovies(page: Int, completion: @escaping (Result<[TMMovie], Error>) -> Void) {
        let url = "\(TMDBApiInfo.baseURL)/discover/movie"
        let parameters: [String: Any] = [
            "page": page,
            "include_adult": false,
            "include_video": false,
            "language": "en-US",
            "sort_by": "popularity.desc"
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": TMDBApiInfo.apiKey
        ]
        
        let request = AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()

        request.responseDecodable(of: TMMovieListResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
