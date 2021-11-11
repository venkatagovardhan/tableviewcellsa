//
//  JSONResponse.swift
//  test-app
//
//  Created by Mahesh Dhumpeti on 08/11/21.
//

import Foundation

struct Occupation: Decodable {
    let code: String
    let description: String
}

struct SourceOfIncomes: Decodable {
    let code: String
    let description: String
    let occupations: [Occupation]
}

struct StatusInfo: Decodable {
    let statuscode: String
}

struct EligibilityResponse: Decodable {
    let isValid: Bool
    let isEligibleReason: String?
}

struct JSONResponse: Decodable {
    let sourceOfIncomes: [SourceOfIncomes]
    let statusInfo: StatusInfo
    let eligibilityResponse: EligibilityResponse
}
