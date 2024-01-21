//
//  Status.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 21/1/24.
//

import Foundation

struct Status: Codable {
    let id:Int = 1
    let version: Int
    let build: Int
    let update: String
    let name: String
}

struct ServerStatus: Codable{
    let id:Int = 1
    let status: Status
}
