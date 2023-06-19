//
//  ForgotPasswordRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class ForgotPasswordRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to initiate the forgotten password flow with Strapi local authentication.
    /// - Parameters:
    ///   - identifer: The identifer used for the user object..
    ///   - password: The password for the user.
    public init(email: String) {
        let body = """
            { "email": \(email) }
        """
        
        super.init(method: .post, contentType: "auth", path: "/forgot-password")
        setBody(to: body)
        
    }
}
