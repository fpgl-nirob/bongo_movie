//
//  PhotoListModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation

struct TopRatedMoviesListModel: Decodable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    let movies: [TopRatedMoviesModel]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case movies = "results"
        case page = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TopRatedMoviesModel: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Float?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Float?
    let voteCount: Int?
    
    var backdropUrl: URL? {
        if let backdropPath = backdropPath { return URL(string: APIConstants.imageUrl + backdropPath) }
        return nil
    }
    
    var posterUrl: URL? {
        if let posterPath = posterPath { return URL(string: APIConstants.imageUrl + posterPath) }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case adult  = "adult"
        case backdropPath  = "backdrop_path"
        case genreIds  = "genre_ids"
        case id  = "id"
        case originalLanguage  = "original_language"
        case originalTitle  = "original_title"
        case overview  = "overview"
        case popularity  = "popularity"
        case posterPath  = "poster_path"
        case releaseDate  = "release_date"
        case title  = "title"
        case video  = "video"
        case voteAverage  = "vote_average"
        case voteCount  = "vote_count"
    }
}
