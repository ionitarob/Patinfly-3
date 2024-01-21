import SwiftUI
import CoreLocation

struct ScooterDetailView: View {
    var scooter: Scooter
    var userLocation: CLLocation?

    @State private var isRentConfirmationVisible = false
    @State private var isScooterRented = false
    @State private var rentalStartTime: Date?
    @State private var rentalTimeInSeconds = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(scooter.name)
                .font(.title)
                .bold()

            Text("Battery Level: \(Int(scooter.battery_level))%")

            Text("Distance: \(formattedDistance())")

            Text("Status: \(scooter.state)")

            Text("Last Maintenance: \(scooter.date_last_maintenance ?? "No date")")

            Text("KM Used: \(scooter.meters_use)")

            Spacer()

            // Muestra el mensaje de confirmación si el patinete no está actualmente en alquiler
            if !isScooterRented {
                Button(action: {
                    if canRentScooter() {
                        isRentConfirmationVisible = true
                    } else {
                        // Puedes mostrar algún mensaje o lógica si no se puede alquilar
                    }
                }) {
                    Text(rentButtonText())
                }
                .buttonStyle(ScooterButtonStyle(disabled: isRentButtonDisabled()))
                .padding()
                .frame(maxWidth: .infinity)
                .alert(isPresented: $isRentConfirmationVisible) {
                    Alert(
                        title: Text("¿Rentar el patinete?"),
                        message: Text("¿Estás seguro de que quieres rentar el patinete?"),
                        primaryButton: .default(Text("Sí")) {
                            rentScooter()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }

            // Muestra el contador de tiempo si el patinete está actualmente en alquiler
            if isScooterRented {
                Text("Tiempo de alquiler: \(formattedRentalTime())")

                Button(action: {
                    finishRent()
                }) {
                    Text("Finish Rent")
                }
                .buttonStyle(ScooterButtonStyle(disabled: false))  // El botón siempre está habilitado para finalizar el alquiler
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .navigationTitle("Detalles del Patinete")
    }

    private func canRentScooter() -> Bool {
        return !isScooterRented && !scooter.vacant && !isRentButtonDisabled()
    }

    private func isRentButtonDisabled() -> Bool {
        return scooter.state.lowercased() == "maintenance" || scooter.state.lowercased() == "inactive" || isScooterRented || scooter.vacant
    }

    private func calculateDistance() -> Double {
        guard let userLocation = userLocation else {
            return 0.0
        }

        let userCoordinate = userLocation.coordinate
        let scooterCoordinate = CLLocationCoordinate2D(latitude: scooter.longitude, longitude: scooter.latitude)

        let R = 6371.0  // Earth's radius in kilometers
        let lat1 = userCoordinate.latitude.toRadians()
        let lon1 = userCoordinate.longitude.toRadians()
        let lat2 = scooterCoordinate.latitude.toRadians()
        let lon2 = scooterCoordinate.longitude.toRadians()

        let dLon = lon2 - lon1
        let dLat = lat2 - lat1

        let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        let distance = R * c
        return distance
    }

    private func formattedDistance() -> String {
        let distance = calculateDistance()

        if distance < 1.0 {
            let distanceInMeters = Int(distance * 1000)
            return "\(distanceInMeters) meters"
        } else {
            return "\(Int(distance)) km"
        }
    }

    private func rentButtonText() -> String {
        return isScooterRented ? "Finish Rent" : "Rent Scooter"
    }

    private func rentScooter() {
        guard canRentScooter() else {
            return
        }

        // Inicia el contador de tiempo al rentar el patinete
        startRentalTimer()

        isScooterRented = true
        rentalStartTime = Date()
        print("Patinete alquilado: \(scooter.name)")
    }

    private func startRentalTimer() {
        // Inicia un temporizador para rastrear el tiempo de alquiler
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            rentalTimeInSeconds += 1
        }

        // Detiene el temporizador después de que la vista desaparezca
        timer.tolerance = 0.1
        RunLoop.current.add(timer, forMode: .common)
    }

    private func finishRent() {
        // Detiene el contador de tiempo al finalizar el alquiler
        rentalTimeInSeconds = 0
        isScooterRented = false
        print("Patinete devuelto: \(scooter.name)")
    }

    private func formattedRentalTime() -> String {
        // Formatea el tiempo de alquiler en horas, minutos y segundos
        let hours = rentalTimeInSeconds / 3600
        let minutes = (rentalTimeInSeconds % 3600) / 60
        let seconds = rentalTimeInSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct ScooterButtonStyle: ButtonStyle {
    let disabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(disabled ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(disabled ? Color.clear : Color.blue, lineWidth: 2)
            )
    }
}

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}
