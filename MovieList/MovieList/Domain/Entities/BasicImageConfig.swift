//
//  BasicImageConfig.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

struct BasicImageConfig {
    let baseURL: String
    let size: String
    
    func composeImageURL(imageBackDrop: String) -> URL? {
        return URL(string: baseURL+size+imageBackDrop)
    }
}
