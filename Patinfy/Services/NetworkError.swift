//
//  NetworkError.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 21/1/24.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

extension NetworkError {
    
    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode) {
            self = .serverError(statusCode: response.statusCode)
            return
        }
        
        if data == nil {
            self = .noData
        }
        
        return nil
    }
}
