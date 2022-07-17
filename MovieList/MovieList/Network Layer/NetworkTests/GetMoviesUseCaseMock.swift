//
//  GetMoviesUseCaseMock.swift
//  MovieListTests
//
//  Created by Ali Youssef on 17/07/2022.
//

import Foundation
import RxCocoa
import RxSwift

class GetMoviesUseCaseMock: GetMoviesUseCase {
    
    private let mockMoviesList = """
        {
            "page": 1,
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/qTkJ6kbTeSjqfHCFCmWnfWZJOtm.jpg",
                    "genre_ids": [
                        10751,
                        16,
                        12,
                        35,
                        14
                    ],
                    "id": 438148,
                    "original_language": "en",
                    "original_title": "Minions: The Rise of Gru",
                    "overview": "A fanboy of a supervillain supergroup known as the Vicious 6, Gru hatches a plan to become evil enough to join them, with the backup of his followers, the Minions.",
                    "popularity": 11846.631,
                    "poster_path": "/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg",
                    "release_date": "2022-06-29",
                    "title": "Minions: The Rise of Gru",
                    "video": false,
                    "vote_average": 7.6,
                    "vote_count": 354
                },
                {
                    "adult": false,
                    "backdrop_path": "/9eAn20y26wtB3aet7w9lHjuSgZ3.jpg",
                    "genre_ids": [
                        12,
                        28,
                        878
                    ],
                    "id": 507086,
                    "original_language": "en",
                    "original_title": "Jurassic World Dominion",
                    "overview": "Four years after Isla Nublar was destroyed, dinosaurs now live—and hunt—alongside humans all over the world. This fragile balance will reshape the future and determine, once and for all, whether human beings are to remain the apex predators on a planet they now share with history’s most fearsome creatures.",
                    "popularity": 6252.796,
                    "poster_path": "/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg",
                    "release_date": "2022-06-01",
                    "title": "Jurassic World Dominion",
                    "video": false,
                    "vote_average": 6.9,
                    "vote_count": 1396
                }
            ],
            "total_pages": 34342,
            "total_results": 686826
        }
    """
    
    private let mockConfig = """
        {
            "images": {
                "base_url": "http://image.tmdb.org/t/p/",
                "secure_base_url": "https://image.tmdb.org/t/p/",
                "backdrop_sizes": [
                    "w300",
                    "w780",
                    "w1280",
                    "original"
                ],
                "logo_sizes": [
                    "w45",
                    "w92",
                    "w154",
                    "w185",
                    "w300",
                    "w500",
                    "original"
                ],
                "poster_sizes": [
                    "w92",
                    "w154",
                    "w185",
                    "w342",
                    "w500",
                    "w780",
                    "original"
                ],
                "profile_sizes": [
                    "w45",
                    "w185",
                    "h632",
                    "original"
                ],
                "still_sizes": [
                    "w92",
                    "w185",
                    "w300",
                    "original"
                ]
            },
            "change_keys": [
                "adult",
                "air_date",
                "also_known_as",
                "alternative_titles",
                "biography",
                "birthday",
                "budget",
                "cast",
                "certifications",
                "character_names",
                "created_by",
                "crew",
                "deathday",
                "episode",
                "episode_number",
                "episode_run_time",
                "freebase_id",
                "freebase_mid",
                "general",
                "genres",
                "guest_stars",
                "homepage",
                "images",
            ]
        }
    """
    
    var paginationInfo: PaginationInfo?
    let network = Network<MoviesListResponse>(scheme: "https", host: "api.themoviedb.org")
    
    func getMoviesPage() -> Observable<MoviesListResponse> {
        let moviesList = try! JSONDecoder().decode(MoviesListResponse.self, from: Data(mockMoviesList.utf8))
        return Observable.just(moviesList)
    }
    
    func getConfiguration() -> Observable<Configuration> {
        let config = try! JSONDecoder().decode(Configuration.self, from: Data(mockConfig.utf8))
        return Observable.just(config)
    }
}

class MockNetworkProvider {
    func makeGetMovieNetworkUseCase() -> GetMoviesUseCaseMock {
        return GetMoviesUseCaseMock()
    }
}

class MockNetworkUseCaseProvider: UseCaseProvider {
    private let networkProvider: MockNetworkProvider
    
    public init() {
        networkProvider = MockNetworkProvider()
    }
    
    func makeGetMovieListUseCase() -> GetMoviesUseCase {
        return networkProvider.makeGetMovieNetworkUseCase()
    }
}
