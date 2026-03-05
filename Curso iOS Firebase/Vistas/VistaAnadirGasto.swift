//
//  VistaAnadirGasto.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI

struct VistaAnadirGasto: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: GastosViewModel
    
    @State private var titulo = ""
    @State private var importe: Double = 0.0
    @State private var idCategoriaSeleccionada: String = ""
    
    @State private var mostrarCategorias = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Concepto (ej. Compra del Día)", text: $titulo)
                
                TextField("Importe", value: $importe, format: .number)
                    .keyboardType(.decimalPad)
                
                Picker("Categoría", selection: $idCategoriaSeleccionada) {
                    if viewModel.categorias.isEmpty {
                        Text("No hay categorías")
                            .tag("")
                    }
                    ForEach(viewModel.categorias) { categoria in
                        HStack {
                            Image(systemName: categoria.icono)
                            Text(categoria.nombre)
                        }
                        .tag(categoria.id ?? "")
                    }
                }
                .onAppear {
                    // Preseleccionar la primera categoría que haya, si existe
                    if let primera = viewModel.categorias.first, idCategoriaSeleccionada.isEmpty {
                        idCategoriaSeleccionada = primera.id ?? ""
                    }
                }
            }
            .navigationTitle("Nuevo gasto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        viewModel.anadirGasto(titulo: titulo, importe: importe, idCategoria: idCategoriaSeleccionada)
                        dismiss()
                    }
                    .disabled(titulo.isEmpty || importe == 0)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Categorías") {
                        mostrarCategorias = true
                    }
                    .buttonStyle(.borderless)
                    .tint(.orange)
                }
            }
            .sheet(isPresented: $mostrarCategorias) {
                VistaNuevaCategoria(viewModel: viewModel)
            }
        }
    }
}
