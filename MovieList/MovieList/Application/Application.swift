//
//  Application.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import UIKit
 
final class Application {
    
    static let shared = Application()
    private let networkUseCaseProvider: UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkUseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow?) {
        let navigationView = UINavigationController()
        window?.rootViewController = navigationView
        window?.makeKeyAndVisible()
        
        let movieNavigator = MovieListNavigator(services: networkUseCaseProvider, navigator: navigationView)
        movieNavigator.toMovieListView()
    }
}
