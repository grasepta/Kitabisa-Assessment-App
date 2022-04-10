//
//  MoviesModel.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 10/04/22.
//

import Foundation

struct preferencesModel {
    var name : String
    var isOpen : Bool = false
}

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    var movies: [MovieModel]?
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

// MARK: - Result
struct MovieModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
