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
    
    var idUsuario: String   // Necesario para saber de qué usuario es el gasto
    var idCategoria: String // Cada gasto se asocia a una categoría de la colección Categorías
    
    enum CodingKeys: String, CodingKey {
        case id, titulo, importe, fecha, idUsuario, idCategoria
    }
}
