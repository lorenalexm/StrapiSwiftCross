//
//  MockedData.swift
//  
//
//  Created by Alex Loren on 6/21/23.
//

import Mocker

public final class MockedData {
    public static let jsonWithoutErrors = """
    {
      "data": [
        {
          "id": 1,
          "title": "Surprising Title",
          "detailed": "This is some detailed text about something.",
          "createdAt": "2023-06-20T17:35:50.642Z",
          "updatedAt": "2023-06-20T17:35:50.642Z"
        }
      ],
      "meta": {
        "pagination": {
          "page": 1,
          "pageSize": 25,
          "pageCount": 1,
          "total": 1
        }
      }
    }
    """
    
    public static let jsonWithForbiddenError = """
        {
          "data": null,
          "error": {
            "status": 403,
            "name": "ForbiddenError",
            "message": "Forbidden",
            "details": {}
          }
        }
    """
}
