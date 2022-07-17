//
//  PaginationInfo.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

class PaginationInfo {
    var pageNumber: Int
    let maxPageNumber: Int
    let totalItems: Int
    
    init(pageNumber: Int, maxPageNumber: Int, totalitems: Int) {
        self.pageNumber = pageNumber
        self.maxPageNumber = maxPageNumber
        self.totalItems = totalitems
    }
}
