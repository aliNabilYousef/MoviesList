//
//  UseCaseProvider.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

protocol UseCaseProvider {
    func makeGetMovieListUseCase() -> GetMoviesUseCase
}
