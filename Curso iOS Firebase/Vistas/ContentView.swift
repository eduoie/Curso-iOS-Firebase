//
//  ContentView.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var manager = AuthManager()
    
    var body: some View {
        Group {
            if manager.user != nil {
                VistaGastos(authManager: manager)
            } else {
                VistaLogin(authManager: manager)
            }
        }
    }
}

#Preview {
    ContentView()
}
