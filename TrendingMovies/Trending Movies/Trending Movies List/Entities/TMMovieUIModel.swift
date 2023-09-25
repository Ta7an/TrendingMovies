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
    private let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    // Add any other properties needed for presentation
    init(movie: TMMovie) {
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        // Initialize other properties as needed
    }
    func posterURL(using imagesConfig: TMImagesConfig?, largePosterSize: Bool = false) -> URL {
        return posterURL(for: posterPath, imagesConfig: imagesConfig, largePosterSize: largePosterSize)
    }
    /// The first two pieces can be retrieved by calling the /configuration API and the third is the file path you're wishing to grab on a particular media object.
    /// Here's what a full image URL looks like if the poster_path of /1E5baAaEse26fej7uHcjOgEE2t2.jpg was returned for a movie, and you were looking for the w500 size:
    ///
    ///  Example
    ///   https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg
    /// - Parameters:
    ///   - posterPath: Movie's paster path
    ///   - imagesConfig: images config object
    /// - Returns: Movie's poster URL
    private func posterURL(for posterPath: String?, imagesConfig: TMImagesConfig?, largePosterSize: Bool = false) -> URL {
        let posterSize = largePosterSize ? imagesConfig?.posterSizes.last : imagesConfig?.posterSizes.first
        guard let baseURL = imagesConfig?.secureBaseURL,
              let posterPath = posterPath,
              let posterSize = posterSize else {
            return URL(fileURLWithPath: "")
        }
        let path = baseURL + posterSize + posterPath
        return URL(string: path) ?? URL(fileURLWithPath: "")
    }
}
