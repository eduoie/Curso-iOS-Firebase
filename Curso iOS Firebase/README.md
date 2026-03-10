###  Configuración de seguridad en Firebase

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Reglas para la colección de GASTOS
    match /gastos/{documentId} {
      // Para crear: comprobamos que el dato que llega (request.resource) tenga el ID del usuario
      allow create: if request.auth != null && request.resource.data.idUsuario == request.auth.uid;
      
      // Para leer/borrar/editar: comprobamos que el dato QUE YA EXISTE (resource) tenga el ID
      allow read, update, delete: if request.auth != null && resource.data.idUsuario == request.auth.uid;
    }

    // Reglas para la colección de CATEGORIAS
    // Solo el usuario puede ver/crear sus propias categorías
    match /categorias/{documentId} {
      allow create: if request.auth != null && request.resource.data.idUsuario == request.auth.uid;
      allow read, update, delete: if request.auth != null && resource.data.idUsuario == request.auth.uid;
    }
  }
}
```
