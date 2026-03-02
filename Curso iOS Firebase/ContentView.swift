//
//  ContentView.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var manager = AuthManager()
    
    var body: some View {
        Group {
            if manager.user != nil {
                VistaPrincipal(authManager: manager)
            } else {
                VistaLogin(authManager: manager)
            }
        }
    }
}

#Preview {
    ContentView()
}
