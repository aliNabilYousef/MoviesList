//
//  GetMoviesUseCase.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GetMoviesUseCase {
    var paginationInfo: PaginationInfo? { get set }
    func getMoviesPage() -> Observable<MoviesListResponse>
    func getConfiguration() -> Observable<Configuration>
}
