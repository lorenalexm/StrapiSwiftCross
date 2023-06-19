//
//  RegisterRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class RegisterRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to register a new user with Strapi.
    /// - Parameters:
    ///   - username: The requested username for the user.
    ///   - email: The email to be associated with the user.
    ///   - password: The password for the account to be created.
    public init(username: String, email: String, password: String) {
        let body = """
            { "username": \(username), "email": \(email), "password": \(password) }
        """
        
        super.init(method: .post, contentType: "auth", path: "/local/register")
        setBody(to: body)
    }
}
