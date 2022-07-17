//
//  ImageConfiguration.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class ImageConfiguration: Decodable {
    let baseUrl: String
    let backDropSize: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "secure_base_url"
        case backDropSize = "backdrop_sizes"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baseUrl = try values.decode(String.self, forKey: .baseUrl)
        backDropSize = try values.decode([String].self, forKey: .backDropSize)
    }
}
