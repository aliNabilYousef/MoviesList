//
//  MovieEntryTableViewModel.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class MovieEntryTableViewModel {
    
    private let movie: Movie
    let title: String
    let image: URL?
    let releaseDate: String
    
    init(withMovie movie: Movie) {
        self.movie = movie
        title = movie.title
        image = movie.fullImagePath
        releaseDate = movie.releaseDate
    }
}
