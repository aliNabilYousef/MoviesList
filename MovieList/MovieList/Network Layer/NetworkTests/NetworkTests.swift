//
//  NetworkTests.swift
//  MovieListTests
//
//  Created by Ali Youssef on 16/07/2022.
//

import XCTest
@testable import MovieList
import RxSwift
import RxCocoa

class NetworkTests: XCTestCase {
    let mockUseCaseProvier = MockNetworkProvider().makeGetMovieNetworkUseCase()
    let disposeBag = DisposeBag()
    
    func test_request_get() throws {
        // Given
        let request = Request<MoviesListResponse>.get(atEndpoint: .getMovieList, output: .json)
        
        // When
        let urlRequest = try mockUseCaseProvier.network.api.urlRequest(for: request)
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.themoviedb.org/3/discover/movie?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3")
    }
    
    func test_mock_config() {
        let config = mockUseCaseProvier.getConfiguration()
        config.subscribe { configuration in
            configuration.map { conf in
                XCTAssertEqual(conf.asDomain().baseURL, "https://image.tmdb.org/t/p/")
                XCTAssertEqual(conf.asDomain().size, "w300")
                XCTAssertEqual(conf.asDomain().composeImageURL(imageBackDrop: "/test"), URL(string: "https://image.tmdb.org/t/p/w300/test"))
            }
        }.disposed(by: disposeBag)
    }
    
    func test_mock_moviesList() {
        let movies = mockUseCaseProvier.getMoviesPage()
        movies.subscribe { moviesResponse in
            moviesResponse.map { movRes in
                XCTAssertEqual(movRes.page, 1)
                XCTAssertEqual(movRes.results.count, 2)
                XCTAssertEqual(movRes.asDomain().pageNumber, 1)
                XCTAssertEqual(movRes.asDomain().totalItems, 686826)
            }
        }.disposed(by: disposeBag)

    }
}
