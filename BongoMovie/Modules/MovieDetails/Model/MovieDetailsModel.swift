//
//  MovieDetailsModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 11/4/22.
//

import Foundation

struct MovieDetailsModel: Decodable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    let adult: Bool?
    let backdropPath: String?
    let belongsCollections: BelongCollection?
    let budget: Int?
    let genres: [Genre]?
    let homePage: String?
    let id: Int?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Float?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
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
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
        
        case adult  = "adult"
        case backdropPath  = "backdrop_path"
        case belongsCollections = "belongs_to_collection"
        case budget
        case genres  = "genres"
        case homePage
        case id  = "id"
        case imdbId = "imdb_id"
        case originalLanguage  = "original_language"
        case originalTitle  = "original_title"
        case overview  = "overview"
        case popularity  = "popularity"
        case posterPath  = "poster_path"
        case productionCompanies  = "production_companies"
        case productionCountries  = "production_countries"
        case releaseDate  = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title  = "title"
        case video  = "video"
        case voteAverage  = "vote_average"
        case voteCount  = "vote_count"
    }
    
    struct Genre: Decodable {
        let id: Int?
        let name: String?
    }

    struct BelongCollection: Decodable {
        let id: Int?
        let name: String?
        let posterPath: String?
        let backDropPath: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case posterPath = "poster_path"
            case backDropPath = "backdrop_path"
        }
    }

    struct ProductionCompany: Decodable {
        let id: Int?
        let name: String?
        let logoPath: String?
        let originalCountry: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case logoPath = "logo_path"
            case originalCountry = "origin_country"
        }
    }

    struct ProductionCountry: Decodable {
        let iso: String?
        let name: String?
        
        enum CodingKeys: String, CodingKey {
            case iso = "iso_3166_1"
            case name
        }
    }

    struct SpokenLanguage: Decodable {
        let iso: String?
        let name: String?
        let englishName: String?
        
        enum CodingKeys: String, CodingKey {
            case iso = "iso_639_1"
            case name
            case englishName = "english_name"
        }
    }
}
