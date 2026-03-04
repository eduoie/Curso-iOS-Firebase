//
//  GastosViewModel.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import Foundation
import FirebaseFirestore

enum ConstantesFirestore {
    static let coleccionGastos = "gastos"
}

// TODO: temporal
protocol GastosViewModelProtocol: Observable {
    var gastos: [Gasto] { get set }
    var importeTotal: Double { get set }
    func escucharDatos()
    func anadirGasto(titulo: String, importe: Double, categoria: CategoriaGastos)
    func borrarGasto(indices: IndexSet)
}

@Observable
class GastosViewModel: GastosViewModelProtocol {
    var gastos: [Gasto] = []
    var importeTotal: Double = 0.0
    
    private var db = Firestore.firestore()
    private var idUsuario: String
    
    init(idUsuario: String) {
        self.idUsuario = idUsuario
        escucharDatos()
    }
    
    func escucharDatos() {
        // Consulta a "gastos" en Firestore, usando el idUsuario
        db.collection(ConstantesFirestore.coleccionGastos)
            .whereField(Gasto.CodingKeys.idUsuario.rawValue, isEqualTo: idUsuario)
            .order(by: Gasto.CodingKeys.fecha.rawValue, descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error al leer los documentos: \(error?.localizedDescription ?? "Error desconocido")")
                    return
                }
                // Mapeo: del documento firestore al array de Gastos
                self.gastos = documents.compactMap { doc -> Gasto? in
                    try? doc.data(as: Gasto.self)
                }
                
                // $0 contiene el acumulado hasta el momento, $1.importe el importe de un gasto
                // reduce(0) indica que empezamos a acumular a partir de 0 (el importe total empieza en 0).
                self.importeTotal = self.gastos.reduce(0) { $0 + $1.importe }
            }
    }
    
    func anadirGasto(titulo: String, importe: Double, categoria: CategoriaGastos) {
        let nuevoGasto = Gasto(titulo: titulo,
                               importe: importe,
                               fecha: Date(),
                               categoria: categoria,
                               idUsuario: idUsuario)
        do {
            try db.collection(ConstantesFirestore.coleccionGastos).addDocument(from: nuevoGasto)
        } catch {
            print("Error guardando: \(error)")
        }
    }
    
    func borrarGasto(indices: IndexSet) {
        indices.forEach { indice in
            let gasto = gastos[indice]
            
            guard let idGasto = gasto.id else { return }
            
            db.collection(ConstantesFirestore.coleccionGastos).document(idGasto).delete { error in
                if let error {
                    print("Error al borrar: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
