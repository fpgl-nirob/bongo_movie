//
//  MovieDetailsTests.swift
//  BongoMovieTests
//
//  Created by mac 2019 on 11/5/22.
//

import XCTest
@testable import BongoMovie

class MovieDetailsTests: XCTestCase {
    
    var movieDetailsVM: MovieDetailsViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieDetailsVM = MovieDetailsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieDetailsVM = nil
    }
    
    func testReleaseText() {
        let productionCountry = MovieDetailsModel.ProductionCountry(iso: "US", name: "United States of America")
        let genres = [MovieDetailsModel.Genre(id: 18, name: "Drama"), MovieDetailsModel.Genre(id: 80, name: "Crime")]
        
        let movieDetailsModel = MovieDetailsModel(success: nil, statusCode: nil, statusMessage: nil, adult: false, backdropPath: "", belongsCollections: nil, budget: 600000, genres: genres, homePage: "", id: 238, imdbId: "", originalLanguage: "US", originalTitle: "The Godfather", overview: "Spanning movie godfather", popularity: 96.5, posterPath: "", productionCompanies: nil, productionCountries: [productionCountry], releaseDate: "1972-03-14", revenue: nil, runtime: 175, spokenLanguages: nil, status: nil, tagline: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil)
        movieDetailsVM.movieDetails = movieDetailsModel
        
        // Do the test
        XCTAssertNotNil(movieDetailsVM.getReleaseText())
        XCTAssertNotEqual(movieDetailsVM.getReleaseText(), "")
    }
    
    func testMovieId() {
        movieDetailsVM.movieId = 238
        
        // Do the test
        XCTAssertNotNil(movieDetailsVM.movieId)
        XCTAssertEqual(movieDetailsVM.movieId, 238)
    }

}
