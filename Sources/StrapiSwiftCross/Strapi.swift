//
//  Strapi.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import Foundation

final public class Strapi {
    // MARK: - Properties
    
    let host: String
    let urlSession: URLSession
    
    // MARK: - Functions
    
    /// Initializes the URLSession and sets the Strapi host.
    /// - Parameters:
    ///   - host: The full url string to the Strapi server.
    ///   - urlSession: If desired a custom URLSession, defaults to a shared session.
    public init(host: String, urlSession: URLSession = URLSession.shared) {
        self.host = host
        self.urlSession = urlSession
    }
    
    /// Sends a request to the Strapi host and returns the JSON as a string.
    /// - Parameters:
    ///   - strapiRequest: The StrapiRequest to send to the server.
    ///   - token: An optional authenication token for the request.
    /// - Returns: A string with the JSON data from the Strapi host.
    public func execute(_ strapiRequest: StrapiRequest, withAuthToken token: String? = nil) async throws -> String {
        let request = try buildURLRequest(from: strapiRequest, withAuthToken: token ?? "")
        let (data, response) = try await urlSession.data(for: request)
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        guard statusCode == 200 else {
            throw StrapiError.badResponse(code: statusCode ?? 0)
        }
        
        guard let raw = String(data: data, encoding: .utf8) else {
            throw StrapiError.parsingError
        }
        
        do {
            let decoded = try JSONDecoder().decode(StrapiResponse.self, from: data)
            guard decoded.error == nil else {
                throw StrapiError.serverResponse(code: decoded.error!.status, message: decoded.error!.message)
            }
        }
        
        return raw
    }
    
    /// Builds the URLRequest from a StrapiRequest to a given URL.
    /// - Parameters:
    ///   - url: Where the request is to be sent.
    ///   - strapiRequest: The StrapiRequest to extract request data from.
    ///   - token: An optional authentication token for the request.
    /// - Returns: A fully formed URLRequest ready to be executed.
    func buildURLRequest(from strapiRequest: StrapiRequest, withAuthToken token: String) throws -> URLRequest{
        guard let url = URL(string: buildURL(from: strapiRequest)) else {
            throw StrapiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = strapiRequest.method.rawValue
        request.addValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if !token.isEmpty {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = strapiRequest.body {
            request.httpBody = body.data(using: .utf8)
        }
        
        return request
    }
    
    /// Builds the url from the host and request for execution
    /// - Parameter from: The request for which to build the URL.
    /// - Returns: A URL to be used within an execution.
    func buildURL(from request: StrapiRequest) -> String {
        var url = host
        url += (url.hasSuffix("/") == false) ? "/" : ""
        url += request.contentType
        url += (request.path.isEmpty) ? "" : request.path
        
        if request.filters!.count > 0 {
            var inIndex = 0
            var notInIndex = 0
            var populationIndex = 0
            var sortIndex = 0
            
            url += "?"
            for filter in request.filters! {
                switch filter.type {
                case "populate":
                    url += "populate[\(populationIndex)]=\(filter.field)"
                    populationIndex += 1
                    break
                    
                case "sort":
                    url += "sort[\(sortIndex)]=\(filter.field):\(filter.value)"
                    sortIndex += 1
                    break
                    
                case "randomSort":
                    url += "randomSort=\(filter.value)"
                    break
                    
                case "pagination":
                    url += "pagination[\(filter.field)]=\(filter.value)"
                    break
                    
                case "$in":
                    url += "filters[\(filter.field)][\(filter.type)][\(String(inIndex))]=\(filter.value)"
                    inIndex += 1
                    break
                    
                case "$notIn":
                    url += "filters[\(filter.field)][\(filter.type)][\(String(notInIndex))]=\(filter.value)"
                    notInIndex += 1
                    break
                    
                case "$null", "$notNull":
                    url += "filters[\(filter.field)][\(filter.type)]"
                    break
                    
                default:
                    url += "filters[\(filter.field)][\(filter.type)]=\(filter.value)"
                    break
                }
                url += "&"
            }
        }
        
        if url.hasSuffix("&") {
            url.removeLast()
        }
        return url
    }
}
