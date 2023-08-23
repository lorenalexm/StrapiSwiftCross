//
//  ResetPasswordRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

/// Request for changing a users password, using the Strapi hosts local authentication method.
public final class ResetPasswordRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to finish the forgotten password flow by reseting the password with Strapi local authentication.
    /// - Parameters:
    ///   - code: The security code received from Strapi.
    ///   - password: The new password for the user.
    ///   - passwordConfirmation: The confirmed new password for the user.
    public init(code: String, password: String, passwordConfirmation: String) {
        let body = """
            { "code": "\(code)", "password": "\(password)", "passwordConfirmation": "\(passwordConfirmation)" }
        """
        
        super.init(method: .post, contentType: "auth", path: "/reset-password")
        setBody(to: body)
    }
}
