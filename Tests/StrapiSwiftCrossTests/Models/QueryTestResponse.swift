//
//  File.swift
//  
//
//  Created by Alex Loren on 6/21/23.
//

import Foundation

struct QueryTestResponse: Codable {
    // MARK: - Properties
    
    let data: [QueryTestData]
}

struct QueryTestData: Codable {
    // MARK: - Properties
    
    let id: Int
    let title: String
    let detailed: String
    let createdAt: String
    let updatedAt: String
}
