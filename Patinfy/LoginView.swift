//
//  LoginView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

// Estructura principal que representa la vista de inicio de sesión
struct LoginView: View {
    
    // Instancia del ViewModel de inicio de sesión
    @StateObject private var loginModelView = LoginViewModel()
    
    // Instancia del objeto de autenticación para el entorno de la aplicación
    @EnvironmentObject var authentication: Authentification
    
    // Variable de estado para rastrear si las condiciones han sido aceptadas
    @State private var conditionsAccepted = false
    
    // Variable de estado para controlar la navegación a la vista de condiciones
    @State private var showConditions = false
    
    var body: some View {
        // Contenedor principal de la vista
        VStack {
            // Título de la aplicación
            Text("Patinfly")
                .font(.largeTitle)
                .foregroundColor(Color("PrimaryColor"))
            
            // Campo de texto para el usuario
            TextField("User", text: $loginModelView.credentials.email)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)
            
            // Campo seguro para la contraseña
            SecureField("Password", text: $loginModelView.credentials.password)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)
            
            // Sección para las condiciones con un interruptor
            HStack {
                Text("Conditions")
                Spacer()
                Toggle("", isOn: $conditionsAccepted)
                    .labelsHidden()
            }
            .padding(20)
            
            // Muestra una barra de progreso si está en progreso una operación de inicio de sesión
            if loginModelView.showProgressView {
                ProgressView()
            }
            
            // Botón de inicio de sesión
            Button("Sign in") {
                guard conditionsAccepted else {
                    // Muestra un mensaje o realiza alguna acción si las condiciones no se han aceptado
                    return
                }
                
                // Intenta realizar la operación de inicio de sesión
                loginModelView.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginModelView.loginDisable || !conditionsAccepted) // Deshabilita si las condiciones no se han aceptado
            .padding(20)
            
            // Texto "Clickable" para consultar las condiciones
            Text("Consult Conditions")
                .foregroundColor(.blue)
                .onTapGesture {
                    showConditions = true
                }
                .sheet(isPresented: $showConditions) {
                    // Vista de condiciones, aquí deberías presentar la vista que muestra las condiciones
                    ConditionsView()
                }
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 20)
        .autocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .disabled(loginModelView.showProgressView)
        .alert(item: $loginModelView.error) { error in
            Alert(title: Text("Error Validacion"), message:
                    Text(error.localizedDescription))
        }
    }
}

// Estructura que representa la vista de condiciones
struct ConditionsView: View {
    var body: some View {
        // Contenedor principal de la vista de condiciones con desplazamiento
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Título de las condiciones
                Text("Patinfly App - Terms and Conditions")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                // Introducción a las condiciones
                Text("By using the Patinfly mobile application (\"App\"), you agree to the following terms and conditions:")
                    .padding(.bottom, 10)
                
                // Sección 1 de las condiciones
                Group {
                    Text("1. Acceptance of Terms:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - By accessing or using the Patinfly App, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.")
                }
                .padding(.bottom, 10)
                
                // Sección 2 de las condiciones
                Group {
                    Text("2. User Eligibility:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Users must be at least 18 years old to use the Patinfly App. By using the App, you confirm that you meet this age requirement.")
                }
                .padding(.bottom, 10)
                
                // Sección 3 de las condiciones
                Group {
                    Text("3. Account Registration:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Users are required to create an account to use Patinfly. You agree to provide accurate, current, and complete information during the registration process.")
                }
                .padding(.bottom, 10)
                
                // Sección 4 de las condiciones
                Group {
                    Text("4. Scooter Rental:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Patinfly provides electric scooters for short-term rental. Users are responsible for the proper use and care of the scooters and must follow local traffic laws and regulations.")
                }
                .padding(.bottom, 10)
                
                // Sección 5 de las condiciones
                Group {
                    Text("5. Safety Guidelines:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Users must wear appropriate safety gear, including helmets, while using Patinfly scooters. It is your responsibility to ride responsibly and be aware of your surroundings.")
                }
                .padding(.bottom, 10)
                
                // Sección 6 de las condiciones
                Group {
                    Text("6. Payment and Fees:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Users agree to pay all applicable fees associated with the use of Patinfly services. This includes rental fees, damage fees, and any other charges as outlined in the App.")
                }
                .padding(.bottom, 10)
                
                // Sección 7 de las condiciones
                Group {
                    Text("7. Prohibited Activities:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Users must not engage in any illegal activities while using Patinfly. This includes, but is not limited to, reckless riding, vandalism, and violation of traffic laws.")
                }
                .padding(.bottom, 10)
                
                // Sección 8 de las condiciones
                Group {
                    Text("8. Liability:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Patinfly is not liable for any injuries, accidents, or damages that may occur during the use of its services. Users assume all risks associated with the use of Patinfly scooters.")
                }
                .padding(.bottom, 10)
                
                // Sección 9 de las condiciones
                Group {
                    Text("9. Termination of Services:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Patinfly reserves the right to terminate or suspend your account at any time for violation of these terms and conditions or for any other reason deemed appropriate by the company.")
                }
                .padding(.bottom, 10)
                
                // Sección 10 de las condiciones
                Group {
                    Text("10. Privacy Policy:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("   - Your use of the Patinfly App is also governed by our Privacy Policy, which outlines how we collect, use, and protect your personal information.")
                }
                .padding(.bottom, 10)
                
                // Conclusión y recordatorio de revisar las condiciones periódicamente
                Text("By using the Patinfly App, you agree to abide by these terms and conditions. Patinfly reserves the right to update or modify these terms at any time, and users are encouraged to review them periodically. If you do not agree with these terms, please refrain from using the Patinfly App.")
                    .padding(.top, 20)
            }
            .padding(20)
        }
    }
}

// Estructura de vista previa para previsualizar la vista de inicio de sesión
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



