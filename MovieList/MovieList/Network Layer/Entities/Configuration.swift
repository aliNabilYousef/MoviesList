//
//  Configuration.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class Configuration: Decodable, DomainConvertable {
    
    let imagesConfig: ImageConfiguration
    
    enum CodingKeys: String, CodingKey {
        case imagesConfig = "images"
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        imagesConfig = try value.decode(ImageConfiguration.self, forKey: .imagesConfig)
    }
    
    func asDomain() -> BasicImageConfig {
        return BasicImageConfig(baseURL: imagesConfig.baseUrl, size: imagesConfig.backDropSize.first ?? "")
    }
}
