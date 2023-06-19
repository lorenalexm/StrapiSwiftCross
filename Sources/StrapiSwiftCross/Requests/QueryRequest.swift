//
//  QueryRequest.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import Foundation

public final class QueryRequest: StrapiRequest {
    // MARK: - Functions
    public init(contentType: String) {
        super.init(method: .get, contentType: contentType)
    }
}
