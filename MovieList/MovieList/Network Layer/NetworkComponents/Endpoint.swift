//
//  Endpoint.swift
//  MoviesList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

public enum Endpoint {
    case getMovieList
    case getConfiguration
    case getMovieDetails(movieId: String)
    
    func fullPath() -> String {
        switch self {
        case .getConfiguration: return "/3/configuration"
        case .getMovieList: return "/3/discover/movie"
        case .getMovieDetails(movieId: let movieId): return "/3/movie/\(movieId)"
        }
    }
}
