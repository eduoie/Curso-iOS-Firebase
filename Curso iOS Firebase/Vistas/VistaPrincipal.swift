//
//  VistaPrincipal.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI
import FirebaseAuth

struct VistaPrincipal: View {
    var authManager: AuthManager
    
    var body: some View {
        VStack {
            Text("Estás dentro!. ID: \(authManager.user?.uid ?? "No hay usuario")")
            
            Button("Cerrar sesión") {
                authManager.logout()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
    }
}
