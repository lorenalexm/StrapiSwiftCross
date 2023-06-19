//
//  DestroyRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class DestroyRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Creates the request.
    /// - Parameters:
    ///   - contentType: The Strapi type of this content.
    ///   - id: The Strapi ID of the record to delete.
    public init(contentType: String, id: Int) {
        super.init(method: .delete, contentType: contentType, path: "/\(id)")
    }
}
