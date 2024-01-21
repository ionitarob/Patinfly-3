//
//  Constants.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 21/1/24.
//

import Foundation

struct APIConstants{
    static let scheme = "https"
    static let host = "patinfly.com"
    static let token: String = "Nn79f2gHAwBVEdsGcIUy3rMpxtzZuo86h14mKY042324"
    static let urlServer: String = "https://patinfly.com/"
    static let pathStatus: String = "/endpoints/status/"
    static let pathScooter: String = "/endpoints/scooter/"
    
    static func baseURL() -> URLComponents{
        var baseServerURL: URLComponents = URLComponents()
        baseServerURL.scheme = APIConstants.scheme
        baseServerURL.host = APIConstants.host
        return baseServerURL
    }
    
    static func serverStatus() -> URLComponents{
        var urlServerStatus: URLComponents = APIConstants.baseURL()
        urlServerStatus.path = APIConstants.pathStatus
        return urlServerStatus
    }
    
    static func scooters() -> URLComponents{
        var urlServerScooters: URLComponents = APIConstants.baseURL()
        urlServerScooters.path = APIConstants.pathScooter
        return urlServerScooters
    }
    
    
}
