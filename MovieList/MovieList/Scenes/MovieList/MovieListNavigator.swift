//
//  MovieListNavigator.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import UIKit

class MovieListNavigator {
    
    private let services: UseCaseProvider
    private let navigator: UINavigationController
    
    init(services: UseCaseProvider, navigator: UINavigationController) {
        self.services = services
        self.navigator = navigator
    }
    
    func toMovieListView() {
        let vc = MovieListViewController()
        let vm = MovieListViewModel(services: services, navigator: MovieListNavigator(services: services, navigator: navigator))
        vc.bindToViewModel(viewModel: vm)
        navigator.pushViewController(vc, animated: true)
    }
    
    func toDetailsView(movie: Movie) {
        let vc = MovieDetailsViewController()
        let vm = MovieDetailsViewModel(withMovie: movie)
        vc.bindToViewModel(viewModel: vm)
        navigator.pushViewController(vc, animated: true)
    }
}
