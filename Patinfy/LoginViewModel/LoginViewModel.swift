//
//  LoginViewModel.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentification.AuthentificationError?
    
    var loginDisable: Bool{
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completition: @escaping (Bool) -> Void){
        showProgressView = true
        Authentification().login(credentials: credentials){[unowned self] (result:Result<Bool, Authentification.AuthentificationError>) in
            showProgressView = false
            switch result{
            case .success:
                completition(true)
            case .failure(let authError):
                credentials = Credentials()
                error = authError
                completition(false)
            }
        }
    }
}

