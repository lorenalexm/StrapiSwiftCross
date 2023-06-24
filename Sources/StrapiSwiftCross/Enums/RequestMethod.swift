//
//  RequestMethod.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

/// The available HTTP request types that can be used when building a custom ``StrapiRequest``.
public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
