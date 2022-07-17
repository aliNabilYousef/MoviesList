//
//  GetMoviesNetworkUseCase.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class GetMoviesNetworkUseCase: GetMoviesUseCase {
    
    private let network: Network<MoviesListResponse>
    
    init(network: Network<MoviesListResponse>) {
        self.network = network
    }
    
    var paginationInfo: PaginationInfo?
    
    func getMoviesPage() -> Observable<MoviesListResponse> {
        let request = Request<MoviesListResponse>.get(atEndpoint: .getMovieList, parameters: ["page": "\((paginationInfo?.pageNumber ?? 0) + 1)"], output: .json)
        paginationInfo?.pageNumber += 1
        return network.api.result(for: request)
    }
    
    func getConfiguration() -> Observable<Configuration> {
        let request = Request<Configuration>.get(atEndpoint: .getConfiguration, output: .json)
        return network.api.result(for: request)
    }
    
}
