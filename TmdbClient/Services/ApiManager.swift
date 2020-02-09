//
//  Manager.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 07-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class ApiClient {
    
    static let shared = ApiClient()
    
    func requestToApi(url: URL, result: @escaping ((Data?, AlertResponse) -> Void)) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print("Invalid Response")
                return
            }
            
            switch statusCode {
            case 200:
                result(data, AlertResponse(status: .successFetch))
            case 404:
                result(nil, AlertResponse(status: .resourceNotFound))
            default:
                result(nil, AlertResponse(status: .serverFail))
            }
        }
        task.resume()
    }
    
    
}
