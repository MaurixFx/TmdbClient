//
//  AlertResponse.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 07-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

struct AlertResponse {
    var status: StatusResponse
    
    func isError() -> Bool {
        if status != StatusResponse.successFetch {
            return true
        }
        return false
    }
    
    func getMessage() -> String {
        switch self.status {
        case .noInternet:
            return "You're not connected to the internet, please check your connection"
        case .resourceNotFound:
            return "There's no resource you're trying to access"
        case .urlNotValid:
            return "The Url is not valid"
        default:
            return "We haven't been able to make a connection, try it later."
        }
    }
}

enum StatusResponse {
    case noInternet
    case urlNotValid
    case successFetch
    case resourceNotFound
    case serverFail
}
