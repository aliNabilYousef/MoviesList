//
//  NetworkProvider.swift
//  MoviesList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class NetworkProvider {
    private let host: String
    private let scheme: String
    
    public init() {
        host = "api.themoviedb.org"
        scheme = "https"
    }
    
    func makeGetMovieNetworkUseCase() -> GetMoviesUseCase {
        let network = Network<MoviesListResponse>(scheme: scheme, host: host)
        return GetMoviesNetworkUseCase(network: network)
    }
}
