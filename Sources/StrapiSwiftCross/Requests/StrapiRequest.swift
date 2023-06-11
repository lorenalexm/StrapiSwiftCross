//
//  StrapiRequest.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import Foundation

class StrapiRequest {
    // MARK: - Properties
    let method: RequestMethod
    let contentType: String
    let path: String
    var body: String?
    var filters: [RequestFilter]?
    
    /// Returns if the request is able to support sending a body.
    public var canSendBody: Bool {
        get {
            return method == .put || method == .post
        }
    }
    
    /// Returns if the request is able to have filters set.
    public var canSendFilters: Bool {
        get {
            return method == .get
            
        }
    }
    
    // MARK: - Functions
    
    /// Initializes a request and sets the parameters for future execution.
    /// - Parameters:
    ///   - method: The RequestMethod to be used for this request.
    ///   - contentType: The Strapi content-type string.
    ///   - path: The path on the server this request will be sent to.
    ///   - filters: Any content specific filters to be sent with the request.
    public init(method: RequestMethod, contentType: String, path: String = "", filters: [RequestFilter] = []) {
        self.method = method
        self.contentType = contentType
        self.path = path
        self.filters = (filters.isEmpty) ? [RequestFilter]() : filters
        self.body = nil
    }
    
    /// Sets the body for any PUT or POST request.
    /// - Parameter value: The body value as a JSON string.
    public func setBody(to value: String) {
        if canSendBody {
            body = value
        }
    }
    
    /// Adds a filter to the request to be sent.
    /// - Parameters:
    ///   - type: The FilterType to be used.
    ///   - onField: A field to apply the filter on.
    ///   - forValue: A value to be filtered for.
    public func addFilter(type: FilterType, onField: String, forValue: String) {
        if canSendFilters {
            filters!.append(RequestFilter(type: type.rawValue, field: onField, value: forValue))
        }
    }
    
    /// Adds a filter to the request to be sent.
    /// - Parameters:
    ///   - type: A valid Strapi filter string to be used.
    ///   - onField: A field to apply the filter on.
    ///   - forValue: A value to be filtered for.
    public func addFilter(type: String, onField: String, forValue: String) {
        if canSendFilters {
            filters!.append(RequestFilter(type: type, field: onField, value: forValue))
        }
    }
    
    /// Removes all stored filters for the request.
    public func removeAllFilters() {
        filters!.removeAll()
    }
    
    /// Sets a starting offset for a GET request.
    /// - Parameter by: The amount to offset the starting index by.
    public func offset(by: Int) {
        addFilter(type: "pagination", onField: "start", forValue: String(by))
    }
    
    /// Sets the limit for the number of items returned in a GET request.
    /// - Parameter to: The maximum number of items that should be returned.
    public func limit(to: Int) {
        addFilter(type: "pagination", onField: "limit", forValue: String(to))
    }
    
    /// Sorts a field for a GET request.
    /// - Parameters:
    ///   - field: A field to apply the sort on.
    ///   - byDirection: The direction that the field should be sorted.
    public func sort(field: String, byDirection: SortDirection) {
        addFilter(type: "sort", onField: field, forValue: byDirection.rawValue)
    }
    
    /// Randomly sorts the results for a GET request.
    /// - Note: Requires the installation of the "strapi-plugin-random-sort" plugin on the Strapi server.
    public func randomize() {
        addFilter(type: "randomSort", onField: "", forValue: "true")
    }
    
    /// Populates a content-types relations for a GET request.
    /// - Parameter relation: The name of the content-type to populate. A wildcard \* can be used to populate all relations.
    public func populate(relation: String) {
        addFilter(type: "populate", onField: relation, forValue: "")
    }
}
