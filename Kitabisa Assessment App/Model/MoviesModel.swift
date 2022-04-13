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

// MARK: - MoviesDetail
struct MoviesDetailModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var homepage: String?
    var id: Int?
    var imdbID, originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var revenue, runtime: Int?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - ReviewList
struct ReviewsResponse: Codable {
    var reviews: [ReviewModel]?

    enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
}

// MARK: - Result
struct ReviewModel: Codable {
    var author: String?
    var content, createdAt, id, updatedAt: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

