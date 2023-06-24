//
//  RequestFilter.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

/// Model for filters that can be applied to any ``StrapiRequest``.
public struct RequestFilter {
    // MARK: - Properties
    public let type: String
    public let field: String
    public let value: String
}
