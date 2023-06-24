//
//  MeRequest.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import Foundation

/// Request for retrieving all of a users information, limited to the Users content-type.
/// Capable of retrieving related content-types when used with `populate` function of the ``StrapiRequest``
public final class MeRequest: StrapiRequest {
    // MARK: - Functions
    
    /// Attempts to fetch the Me content for the user.
    public init() {
        super.init(method: .get, contentType: "users", path: "/me")
    }
}
