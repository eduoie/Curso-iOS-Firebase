//
//  VistaAnadirGasto.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import SwiftUI

struct VistaAnadirGasto: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: any GastosViewModelProtocol
    
    @State private var titulo = ""
    @State private var importe: Double = 0.0
    @State private var categoria: CategoriaGastos = .sinCategoria
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Concepto (ej. Compra del Día)", text: $titulo)
                
                TextField("Importe", value: $importe, format: .number)
                    .keyboardType(.decimalPad)
                
                Picker("Categoría", selection: $categoria) {
                    ForEach(CategoriaGastos.allCases, id: \.self) { categoria in
                        Label(categoria.rawValue, systemImage: categoria.nombreIcono)
                            .tag(categoria)
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
                        viewModel.anadirGasto(titulo: titulo, importe: importe, categoria: categoria)
                        dismiss()
                    }
                    .disabled(titulo.isEmpty || importe == 0)
                }
            }
        }
    }
}

#Preview {
    VistaAnadirGasto(viewModel: GastosViewModelMock(idUsuario: "apsdfi"))
}
