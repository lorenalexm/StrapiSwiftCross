//
//  FilterType.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

public enum FilterType: String {
    case includedIn = "$in"
    case notIncludedIn = "$notIn"
    case equalTo = "$eq"
    case notEqualTo = "$ne"
    case lessThan = "$lt"
    case lessThanOrEqualTo = "$lte"
    case greaterThan = "$gt"
    case greaterThanOrEqualTo = "$gte"
    case contains = "$contains"
    case doesNotContain = "$notContains"
    case startsWith = "$startsWith"
    case endsWith = "$endsWith"
    case isNull = "$null"
    case isNotNull = "$notNull"
}
