//
//  TMMovieUIModel.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 20/09/2023.
//

import Foundation

// UI model for Movie
struct TMMovieUIModel {
    let title: String
    let overview: String
    let posterURL: URL
    let releaseDate: String
    let voteAverage: Double
    // Add any other properties needed for presentation
    
    init(movie: TMMovie) {
        self.title = movie.title
        self.overview = movie.overview
        self.posterURL = URL(string: movie.posterPath ?? "") ?? URL(fileURLWithPath: "") // Handle URL initialization
        self.releaseDate = movie.releaseDate ?? ""
        self.voteAverage = movie.voteAverage
        // Initialize other properties as needed
    }
}
