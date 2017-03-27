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
            return "Erro"
        case .notFound:
            return "Não encontrado"
        case .serverError:
            return "Oops"
        case .authorizationError:
            return "Erro"
        case .noError:
            return ""
        default:
            return "Erro"
        }
    }
    
    var message: String {
        switch self {
        case .requestFailed:
            return "Falha ao se conectar ao servidor, uma conexão com a internet é necessária"
        case .notFound:
            return "Não encontrado"
        case .serverError:
            return "Tente novamente mais tarde"
        case .authorizationError:
            return "Você não está autorizado"
        case .noError:
            return ""
        default:
            return "Erro desconhecido"
        }
    }
    
}
