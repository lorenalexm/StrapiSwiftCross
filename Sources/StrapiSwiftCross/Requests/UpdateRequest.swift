//
//  UpdateRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class UpdateRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Creates the request and sets the body.
    /// - Parameters:
    ///   - contentType: The Strapi type of this content.
    ///   - id: The Strapi ID of the record to update.
    ///   - body: The JSON body string.
    public init(contentType: String, id: Int, body: String) {
        super.init(method: .put, contentType: contentType, path: "/\(id)")
        setBody(to: body)
    }
}
