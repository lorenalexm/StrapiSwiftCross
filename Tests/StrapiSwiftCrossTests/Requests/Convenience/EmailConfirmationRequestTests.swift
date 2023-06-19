//
//  EmailConfirmationRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class EmailConfirmationRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating a new EmailConfirmationRequest.
    func testEmailConfirmationRequest() {
        let body = """
            { "email": test@email.com }
        """
        
        let request = EmailConfirmationRequest(email: "test@email.com")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "auth")
        XCTAssertEqual(request.path, "/send-email-confirmation")
        XCTAssertEqual(request.body, body)
    }
}
