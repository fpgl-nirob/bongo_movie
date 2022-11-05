//
//  TopRatedMovesTests.swift
//  BongoMovieTests
//
//  Created by mac 2019 on 11/5/22.
//

import XCTest
@testable import BongoMovie

class TopRatedMovesTests: XCTestCase {
    
    var topratedMovieVM: TopRatedMoviesViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        topratedMovieVM = TopRatedMoviesViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        topratedMovieVM = nil
    }
    
    func testMovieModelNotNil() {
        XCTAssertNotNil(topratedMovieVM.movieModels)
    }

}
