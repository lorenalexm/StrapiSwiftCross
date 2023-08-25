//
//  QueryRequest.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import Foundation

/// Request for retrieving an array of a specific content-type from a Strapi host.
public class QueryRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Creates the query request for specific content.
    /// - Parameters:
    ///   - contentType: The Strapi type of this content.
    public init(contentType: String) {
        super.init(method: .get, contentType: contentType)
    }
}
