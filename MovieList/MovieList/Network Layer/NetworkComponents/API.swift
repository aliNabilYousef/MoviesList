//
//  API.swift
//  MoviesList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

public struct API {
    public enum Error: Swift.Error {
        case invalidURL(components: URLComponents)
    }
    
    private let scheme: String
    private let host: String
    private let apiKey: String
    
    public init(scheme: String, host: String, apiKey: String = "c9856d0cb57c3f14bf75bdc6c063b8f3") {
        self.scheme = scheme
        self.host = host
        self.apiKey = apiKey
    }
    
    public func url<T>(for request: Request<T>) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = request.endpoint
        
        components.queryItems = request.parameters.isEmpty ? nil : request.parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        if let items = components.queryItems {
            components.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        } else {
            components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        }

        guard let url = components.url else {
            throw Error.invalidURL(components: components)
        }
        return url
    }
    
    public func urlRequest<T>(for request: Request<T>) throws -> URLRequest {
        let url = try self.url(for: request)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        for (headerField, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: headerField)
        }
        
        return urlRequest
    }
    
    public func result<T>(for request: Request<T>) -> Observable<T> {
        do {
            return URLSession.shared.rx
                .data(
                    request: try urlRequest(for: request)
                )
                .map { data in
                    try request.decode(data)
                }.asObservable()
            
        } catch {
            return Observable<T>.error(error)
        }
    }
}
