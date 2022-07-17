//
//  Movie.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let imagePath: String
    var fullImagePath: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case imagePath = "backdrop_path"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        imagePath = try values.decode(String.self, forKey: .imagePath)
    }
}
