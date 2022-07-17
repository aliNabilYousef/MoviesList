//
//  MoviesListResponse.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class MoviesListResponse: Decodable, DomainConvertable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
  
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode([Movie].self, forKey: .results)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
    }
    
    func asDomain() -> PaginationInfo {
        return PaginationInfo(pageNumber: page, maxPageNumber: totalPages, totalitems: totalResults)
    }
}
