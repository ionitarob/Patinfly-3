//
//  PatinfyApp.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

// Punto de entrada principal de la aplicación
@main
struct PatinfyApp: App {
    
    // Objeto de estado que maneja la autenticación en toda la aplicación
    @StateObject var authentification = Authentification()
    
    // Definición de la estructura de la escena principal de la aplicación
    var body: some Scene {
        // Grupo de ventana que representa la ventana principal de la aplicación
        WindowGroup {
            // Selecciona la vista a mostrar en la ventana principal en función del estado de autenticación
            
            if authentification.isValidated {
                // Si el usuario está validado, muestra la vista principal (ContentView)
                ContentView().environmentObject(authentification)
            } else {
                // Si el usuario no está validado, muestra la pantalla de presentación (SplashScreen) o la vista de inicio de sesión (LoginView)
                SplashScreen().environmentObject(authentification)
                // Descomenta la línea siguiente y comenta la línea anterior si prefieres mostrar la vista de inicio de sesión en lugar de la pantalla de presentación
                // LoginView().environmentObject(authentification)
            }
        }
    }
}

