////
////  TMNetworkManager.swift
////  TrendingMovies
////
////  Created by Mohamed Eltahan on 17/08/2023.
////
//

import Foundation

struct TMDBApiInfo {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWJhYjk1M2I4YmI5NDRhMjZhZTUzNTY1MDYxYmI0OCIsInN1YiI6IjVkM2YzNzNjNjBiNThkMDAxMzZiMTdlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.stO3kR4vaq6florlgdK3SRlIe-8Fy9sE1MazINv8jl0"
}


//typealias OnApiSuccess = (MovieListResponse) -> Void
//typealias OnApiError = (String) -> Void
//
//struct TMNetworkManager {
//    // declare a constant for your API key
//    let API_KEY = "Bearer " + "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWJhYjk1M2I4YmI5NDRhMjZhZTUzNTY1MDYxYmI0OCIsInN1YiI6IjVkM2YzNzNjNjBiNThkMDAxMzZiMTdlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.stO3kR4vaq6florlgdK3SRlIe-8Fy9sE1MazINv8jl0"
//    
//    // set the URLSession with a default configuration object
//    let session = URLSession(configuration: .default)
//    
//    // function with arguments such as location of type CLLocationCoordinate2D(latitude and longitude) and onSuccess(successful query of the endpoint) or onError(an error response when querying the endpoint)
//    func fetchTrendingMovies(_ onSuccess: @escaping OnApiSuccess, onError: @escaping OnApiError){
//        // URL of endpoint that takes the passed-in latitude, longitude and API key
//        let URL_BASE = "https://api.themoviedb.org/3/discover/movie"
//        
//        // URL constant converted from the URL_BASE above to a string of type URL that the URLSession data task can read from
//        let url = URL(string: "\(URL_BASE)")
//        
//        // task constant that starts the actual querying of the endpoint that'll return actual data, a response code and/or an error
//        let task = session.dataTask(with: url!) { data, response, error in
//            DispatchQueue.main.async {
//                // handle session error
//                if let error = error{
//                    print(error.localizedDescription)
//                    return
//                }
//                
//                // ensure there is data and a server response
//                guard let data = data, let response = response as? HTTPURLResponse else {
//                    print("Invalid data or response")
//                    return
//                }
//                // handle server response codes
//                do {
//                    switch response.statusCode{
//                    case 200:
//                        // parse successful result (weather data)
//                        let weatherData = try JSONDecoder().decode(MovieListResponse.self, from: data)
//                        print(weatherData)
//                        onSuccess(weatherData)
//                    default:
//                        // handle unsuccessful error (400s)
//                    print("Error 400")
//                        onError(error!.localizedDescription)
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        task.resume()
//    }
//}
//
//
//class MovieNetworkHandler {
//    private let baseURL = "https://test.com/test"
//    private let session = URLSession.shared
//    
//    func fetchMovies(page: Int, completion: @escaping (Result<MovieListResponse, NetworkError>) -> Void) {
//        var components = URLComponents(string: baseURL)
//        components?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
//        
//        guard let url = components?.url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(.networkError(error)))
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            switch httpResponse.statusCode {
//            case 200:
//                do {
//                    let decoder = JSONDecoder()
//                    let movieResponse = try decoder.decode(MovieListResponse.self, from: data ?? Data())
//                    completion(.success(movieResponse))
//                } catch {
//                    completion(.failure(.decodingError(error)))
//                }
//            case 400:
//                completion(.failure(.badRequest))
//            case 401:
//                completion(.failure(.unauthorized))
//            case 403:
//                completion(.failure(.forbidden))
//            case 404:
//                completion(.failure(.notFound))
//            // Handle other status codes as needed.
//            default:
//                completion(.failure(.unknownError(httpResponse.statusCode)))
//            }
//        }
//        
//        task.resume()
//    }
//    
//    enum NetworkError: Error {
//        case invalidURL
//        case networkError(Error)
//        case invalidResponse
//        case decodingError(Error)
//        case badRequest
//        case unauthorized
//        case forbidden
//        case notFound
//        case unknownError(Int)
//    }
//}
