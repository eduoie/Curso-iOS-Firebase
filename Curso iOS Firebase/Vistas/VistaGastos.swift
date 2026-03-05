//
//  VistaGastos.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI
import FirebaseAuth

struct VistaGastos: View {
    var authManager: AuthManager
    
    @State private var viewModel: GastosViewModel
    @State private var mostrarAnadir = false
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        let idUsuario = authManager.user?.uid ?? ""
        _viewModel = State(initialValue: GastosViewModel(idUsuario: idUsuario))
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Resumen") {
                    HStack {
                        Text("Total gastado")
                        Spacer()
                        Text(viewModel.importeTotal, format: .currency(code: "EUR"))
                            .bold()
                            .font(.title3)
                    }
                }
                
                Section("Movimientos") {
                    ForEach(viewModel.gastos) { gasto in
                        HStack {
                            
                            if let categoria = viewModel.obtenerCategoria(id: gasto.idCategoria) {
                                VStack {
                                    Image(systemName: categoria.icono)
                                        .foregroundStyle(Color.fromString(categoria.nombreColor))
                                        .font(.title2)
                                        .clipShape(Circle())
                                    
                                    Text(categoria.nombre)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } else {
                                // Pongamos que se borra la categoría pero el gasto existe
                                VStack {
                                    Image(systemName: "questionmark.circle")
                                    Text("Sin categoría")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(gasto.titulo)
                                    .font(.headline)
                                Text(gasto.fecha, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                            Spacer()
                            
                            Text(gasto.importe, format: .currency(code: "EUR"))
                                .bold()
                                .foregroundStyle((gasto.importe >= 0) ? Color.red : Color.green)
                        }
                    }
                    .onDelete(perform: viewModel.borrarGasto)
                }
            }
            
            .navigationTitle("Mis gastos")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        authManager.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAnadir.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarAnadir) {
                VistaAnadirGasto(viewModel: viewModel)
            }
        }
    }
}
