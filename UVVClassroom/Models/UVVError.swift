//
//  UVVError.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 25/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation

enum UVVError:Int {
    case requestFailed
    case notFound = 404
    case authorizationError = 401
    case serverError = 500
    case noError = 200
    case unkownError
    
    var title: String {
        switch self {
        case .requestFailed:
            return "Error"
        case .notFound:
            return "Not found"
        case .serverError:
            return "Oops"
        case .authorizationError:
            return "Error"
        case .noError:
            return ""
        default:
            return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .requestFailed:
            return "Could not connect to server, please check your internet connection"
        case .notFound:
            return "Error 404"
        case .serverError:
            return "Please try again later"
        case .authorizationError:
            return "You are not authorized"
        case .noError:
            return ""
        default:
            return "Unkown error"
        }
    }
    
}
