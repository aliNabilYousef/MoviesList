//
//  NetworkUseCaseProvider.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

final class NetworkUseCaseProvider: UseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    func makeGetMovieListUseCase() -> GetMoviesUseCase {
        return networkProvider.makeGetMovieNetworkUseCase()
    }
}
