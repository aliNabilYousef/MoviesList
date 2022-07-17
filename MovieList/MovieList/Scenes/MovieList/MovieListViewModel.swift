//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel {
    
    let moviesList: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    private let navigator: MovieListNavigator
    private var getMoviesUseCase: GetMoviesUseCase
    private let disposeBag = DisposeBag()
    private var basicImageConfig: BasicImageConfig?
    
    init(services: UseCaseProvider, navigator: MovieListNavigator) {
        self.navigator = navigator
        getMoviesUseCase = services.makeGetMovieListUseCase()
        getConfig()
    }
    
    func getConfig() {
        if getMoviesUseCase.paginationInfo?.totalItems ?? 1000000000 > moviesList.value.count {
            getMoviesUseCase.getConfiguration().subscribe(onNext: {[weak self] config in
                self?.basicImageConfig = config.asDomain()
                self?.getMoviesList()
            }).disposed(by: disposeBag)
        }
    }
    
    func getMoviesList() {
        getMoviesUseCase.getMoviesPage().map {[weak self] moviesResponse in
            if self?.getMoviesUseCase.paginationInfo == nil {
                self?.getMoviesUseCase.paginationInfo = moviesResponse.asDomain()
            }
            return moviesResponse.results.map {[weak self] movie in
                movie.fullImagePath = self?.basicImageConfig?.composeImageURL(imageBackDrop: movie.imagePath)
                return movie
            }
        }.bind(to: moviesList).disposed(by: disposeBag)
    }
    
    func goToMovieDetails(index: Int) {
        print("TEST 112 clicked this index \(index)")
        let movie = moviesList.value[index]
        navigator.toDetailsView(movie: movie)
    }
}
