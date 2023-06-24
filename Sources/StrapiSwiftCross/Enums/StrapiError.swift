//
//  StrapiError.swift
//  
//
//  Created by Alex Loren on 6/20/23.
//

import Foundation

/// Error type used when making requests or receiving data from a Strapi host.
public enum StrapiError: Error {
    case invalidURL
    case parsingError
    case badResponse(code: Int)
    case serverResponse(code: Int, message: String)
    case unexpected(reason: String)
}

/// Provides human readable descriptions of a ``StrapiError``.
extension StrapiError: LocalizedError {
    // MARK: - Properties
    
    public var errorDescription: String? {
        get {
            switch self {
            case .invalidURL:
                return "Could not build a valid URL from the request object."
            case .parsingError:
                return "Could not parse the response from the server into a valid object."
            case .badResponse(let code):
                return "Received a response with a status code of \(code)"
            case .serverResponse(let code, let message):
                return "The server returned an error \(code) with the message: \(message)"
            case .unexpected(let reason):
                return "An unexpected error occured with the reason: \(reason)"
            }
        }
    }
}
