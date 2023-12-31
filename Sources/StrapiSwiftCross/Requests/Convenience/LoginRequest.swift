//
//  LoginRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

/// Request for logging in a user with the Strapi host, using the hosts local authentication method.
public class LoginRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to login the user with Strapi local authentication.
    /// - Parameters:
    ///   - identifer: The identifer used for the user object.
    ///   - password: The password for the user.
    public init(identifier: String, password: String) {
        let body = """
            { "identifier": "\(identifier)", "password": "\(password)" }
        """
        
        super.init(method: .post, contentType: "auth", path: "/local")
        setBody(to: body)
    }
}
