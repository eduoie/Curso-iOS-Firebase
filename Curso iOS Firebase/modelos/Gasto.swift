//
//  Gasto.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import Foundation
import FirebaseFirestore

struct Gasto: Identifiable, Codable {
    // Firestore rellena DocumentID automáticamente
    @DocumentID var id: String?
    
    var titulo: String
    var importe: Double
    var fecha: Date
    
    var categoria: CategoriaGastos = .sinCategoria
    
    var idUsuario: String // Necesario para saber de qué usuario es el gasto
    
    enum CodingKeys: String, CodingKey {
        case id, titulo, importe, fecha, idUsuario, categoria
    }
}
