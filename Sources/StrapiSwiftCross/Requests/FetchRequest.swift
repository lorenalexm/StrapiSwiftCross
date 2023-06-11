//
//  FetchRequest.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import Foundation

public final class FetchRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Creates the fetch request for a specific resource.
    /// - Parameters:
    ///   - contentType: The Strapi type of this content.
    ///   - id: The Strapi ID of the object to fetch.
    public init(contentType: String, id: Int) {
        super.init(method: .get, contentType: contentType, path: "/\(String(id))")
    }
}
