//
//  StrapiResponse.swift
//  
//
//  Created by Alex Loren on 6/21/23.
//

import Foundation

struct StrapiResponse: Codable {
    // MARK: - Properties
    
    let error: StrapiResponseError?
}

struct StrapiResponseError: Codable {
    // MARK: - Properties
    
    let status: Int
    let name: String
    let message: String
}
