//
//  Movie.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright © 2562 Aksorn. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let page: Int
    let results: [Results]
}

struct Results: Codable {
    let id: Double
    let popularity: Double
    let voteCount: Double
    let voteAverage: Double
    let title: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

struct MovieDetail: Codable {
    let id: Double
    let posterPath: String?
    let title: String
    let popularity: Double
    let overview: String
    let genres: [Genres]
    let Language: String
    let voteCount: Double
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case popularity
        case overview
        case genres
        case Language = "original_language"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

struct Genres: Codable {
    let name: String
}
