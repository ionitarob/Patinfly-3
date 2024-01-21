//
//  ScooterRowView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 9/1/24.
//

import SwiftUI

struct ScooterRowView: View {
    let name: String
    let uuid: String
    let distance: String
    let batteryLevel: Double
    let status: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .bold()
                    .foregroundColor(.black)
                    .font(.body)

                HStack {
                    Text("Status: ")
                    Image(systemName: statusIconName())
                        .foregroundColor(statusColor())
                    Text(status)
                        .font(.footnote)  // Tamaño de la letra más pequeño
                }
            }
            .padding(.leading, 10)  // Agrega un espacio a la izquierda

            Spacer()  // Espacio flexible entre las dos columnas

            VStack(alignment: .trailing, spacing: 10) {
                HStack {
                    Text(distance)
                }

                BatteryIconView(batteryLevel: batteryLevel)
            }
            .padding(.trailing, 10)  // Agrega un espacio a la derecha
        }
        .padding(10)  // Añade un relleno general alrededor del contenido
    }

    private func statusIconName() -> String {
        switch status {
        case "ACTIVE":
            return "power"
        case "INACTIVE":
            return "zzz"
        case "MAINTENANCE":
            return "wrench"
        default:
            return "questionmark"
        }
    }

    private func statusColor() -> Color {
        switch status {
        case "ACTIVE":
            return .green
        case "INACTIVE":
            return .red
        case "MAINTENANCE":
            return .yellow
        default:
            return .black
        }
    }
}

