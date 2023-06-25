//
//  NetworkError.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case cannotDecode
    case parameterMissing
    case unauthorized
    case domainRestricted
    case parameterDuplicate
    case unsupportedType
    case unprocessableEntity
    case tooManyRequests
    case internalServerError
    case unknownError
    
    
    var message: String {
        switch self {
        default:
            return rawValue
        }
    }
}

extension NetworkError {
    
    init?(statusCode: Int) {
        switch statusCode {
        case 200:
            return nil
        case 400:
            self = .parameterMissing
        case 401:
            self = .unauthorized
        case 403:
            self = .domainRestricted
        case 409:
            self = .parameterDuplicate
        case 415:
            self = .unsupportedType
        case 422:
            self = .unprocessableEntity
        case 429:
            self = .tooManyRequests
        case 500:
            self = .internalServerError
        default:
            self = .unknownError
        }
    }
}
