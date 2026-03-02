//
//  VistaLogin.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI

struct VistaLogin: View {
    @Bindable var authManager: AuthManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var seEstaRegistrando = false // ¿Registrando o haciendo login?
    @State private var logeando = false
    @State private var mensajeError: String?
    
    var body: some View {
        
    }
}

//#Preview {
//    VistaLogin()
//}
