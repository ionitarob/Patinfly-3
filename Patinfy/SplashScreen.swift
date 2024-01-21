//
//  SplashScreen.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 6/11/23.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject var authentification = Authentification()
    @State private var isActive = false
    @State private var opacity = 0.5
    @State private var size = 0.8
    
    var body: some View {
        if self.isActive{
            if authentification.isValidated{
                ContentView()
            }
            else{
                LoginView()
            }
        }
        else{
            VStack{
                VStack{
                    Image(uiImage: UIImage(named: "Logo") ?? UIImage()).scaleEffect(0.8)
                    Text("Patinfly").font(.title)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{withAnimation(.easeIn(duration: 1.2)){
                    self.size = 1.0
                    self.opacity = 1.0
                }
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}
    struct SplashScreen_Previews:
        PreviewProvider {
        static var previews: some View{
            SplashScreen()
                .previewInterfaceOrientation(.portrait)
            SplashScreen()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }

