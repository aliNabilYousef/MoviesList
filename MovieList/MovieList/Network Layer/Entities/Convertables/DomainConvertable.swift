//
//  DomainConvertable.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

protocol DomainConvertable {
    
    associatedtype domainType
    func asDomain() -> domainType
    
}
