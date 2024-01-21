//
//  BatteryIconView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 9/1/24.
//

import SwiftUI

struct BatteryIconView: View {
    let batteryLevel: Double

    var body: some View {
        HStack {
            Image(systemName: batterySymbolName())
                .foregroundColor(batteryColor())
            Text("\(Int(batteryLevel))%")
        }
    }

    private func batterySymbolName() -> String {
        let batterySymbols: [String] = [
            "battery.0",
            "battery.25",
            "battery.50",
            "battery.75",
            "battery.100"
        ]

        let index = min(Int(batteryLevel / 25), batterySymbols.count - 1)
        return batterySymbols[index]
    }

    private func batteryColor() -> Color {
        switch batteryLevel {
        case 0..<20:
            return .red
        case 20..<50:
            return .orange
        default:
            return .green
        }
    }
}
