//
//  EmailConfirmationRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class EmailConfirmationRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to restart email confirmation flow with Strapi local authentication.
    /// - Parameters:
    ///   - email: The email associated with the user account
    public init(email: String) {
        let body = """
            { "email": \(email) }
        """
        
        super.init(method: .post, contentType: "auth", path: "/send-email-confirmation")
        setBody(to: body)
    }
}
