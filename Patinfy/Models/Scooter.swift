//
//  Scooter.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 8/11/23.
//
import Foundation
import CoreLocation

struct Scooters: Codable{
    let id:Int = 1
    let scooters: [Scooter]
}

struct Scooter: Codable, Identifiable{
    let id:Int = 1
    var uuid: String
    var name: String
    var longitude: Double
    var latitude: Double
    var battery_level: Float
    var date_create: String
    var meters_use: Float
    var date_last_maintenance: String?
    var state: String
    var vacant: Bool
}

// Función para calcular la distancia entre dos ubicaciones en metros
func calculateDistance(userLatitude: Double?, userLongitude: Double?,
                       scooterLatitude: Double, scooterLongitude: Double) -> Double {
    guard let userLat = userLatitude, let userLon = userLongitude else {
        return 0.0  // Si no se proporciona la ubicación del usuario, la distancia es 0
    }

    let userLocation = CLLocation(latitude: userLat, longitude: userLon)
    let scooterLocation = CLLocation(latitude: scooterLatitude, longitude: scooterLongitude)

    // Devuelve la distancia en kilómetros
    return userLocation.distance(from: scooterLocation) / 1000.0
}


