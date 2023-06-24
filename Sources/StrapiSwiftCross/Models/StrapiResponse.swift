//
//  StrapiResponse.swift
//  
//
//  Created by Alex Loren on 6/21/23.
//

import Foundation

/// An imcomplete response model from the Strapi host.
/// Used solely for checking if the host returned an error within a JSON body.
struct StrapiResponse: Codable {
    // MARK: - Properties
    
    let error: StrapiResponseError?
}

/// Models error messages received from the Strapi host.
struct StrapiResponseError: Codable {
    // MARK: - Properties
    
    let status: Int
    let name: String
    let message: String
}
