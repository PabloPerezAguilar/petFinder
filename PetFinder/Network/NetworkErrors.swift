//
//  NetworkErrors.swift
//  PetFinder
//
//  Created by Consultant on 1/25/23.
//

import Foundation

enum NetworkErrors: Error {
    case urlError
    case responseError
    case badCode(_ code: Int)
    case decodeError
    case error(_ error: Error)
    case bodyParseError
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlError:
            return ErrorConstants.urlError
        case .responseError:
            return ErrorConstants.responseError
        case .badCode(let code):
            return "\(code) \(ErrorConstants.responseError)"
        case .decodeError:
            return ErrorConstants.decodeError
        case .error(let error):
            return "\(ErrorConstants.error) \(error)"
        case .bodyParseError:
            return ErrorConstants.bodyParseError
        }
    }
}
