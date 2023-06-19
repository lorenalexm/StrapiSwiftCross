//
//  CreateRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class CreateRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Creates the request and sets the body.
    /// - Parameters:
    ///   - contentType: The Strapi type of this content.
    ///   - body: The JSON body string.
    public init(contentType: String, body: String) {
        super.init(method: .post, contentType: contentType)
        setBody(to: body)
    }
}
