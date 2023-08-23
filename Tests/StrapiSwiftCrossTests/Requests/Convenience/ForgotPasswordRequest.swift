//
//  File.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class ForgotPasswordRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating the ForgotPasswordRequest.
    func testForgotPasswordReqeust() {
        let body = """
            { "email": "test@email.com" }
        """
        
        let request = ForgotPasswordRequest(email: "test@email.com")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "auth")
        XCTAssertEqual(request.path, "/forgot-password")
        XCTAssertEqual(request.body, body)
    }
}
