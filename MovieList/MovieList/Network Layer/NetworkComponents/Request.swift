//
//  Request.swift
//  MoviesList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation

public struct Request<T> {
    public let method: Method
    public let endpoint: String
    public let headers: [String: String]
    public let parameters: [String: String]
    public let body: Data?
    public let output: Output<T>
    
    private init(method: Method, endpoint: Endpoint, headers: [String : String] = [:], parameters: [String : String] = [:], body: Data? = nil, output: Output<T>) {
        self.method = method
        self.endpoint = endpoint.fullPath()
        self.headers = headers
        self.parameters = parameters
        self.body = body
        self.output = output
    }
    
    public static func get(atEndpoint endpoint: Endpoint, parameters: [String: String] = [:], output: Output<T>) -> Request<T> {
        return Request<T>(
            method: .get,
            endpoint: endpoint,
            headers: [:],
            parameters: parameters,
            output: output
        )
    }
    
    public func decode(_ data: Data) throws -> T {
        return try output.decode(data)
    }
}
