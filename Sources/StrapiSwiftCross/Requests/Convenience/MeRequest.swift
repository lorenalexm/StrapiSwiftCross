//
//  MeRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

public final class MeRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to fetch the Me content for the user.
    public init() {
        super.init(method: .get, contentType: "users", path: "/me")
    }
}
