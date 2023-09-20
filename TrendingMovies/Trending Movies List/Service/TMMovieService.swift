//
//  TMMovieService.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 14/09/2023.
//

import Alamofire
import Foundation

class TMMovieService: TMMovieServiceInterface {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWJhYjk1M2I4YmI5NDRhMjZhZTUzNTY1MDYxYmI0OCIsInN1YiI6IjVkM2YzNzNjNjBiNThkMDAxMzZiMTdlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.stO3kR4vaq6florlgdK3SRlIe-8Fy9sE1MazINv8jl0"
    
    func fetchMovies(page: Int, completion: @escaping (Result<[TMMovie], Error>) -> Void) {
        let url = "\(baseURL)/discover/movie"
        let parameters: [String: Any] = [
            "api_key": apiKey,
            "page": page,
            "include_adult": false,
            "include_video": false,
            "language": "en-US",
            "sort_by": "popularity.desc"
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": apiKey
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
