package chat

import seguridad.Persona

class Grupo {

    String nombre
    Persona encargado
    Date fechaCreacion
    Date fechaFin

    static mapping = {
        table 'grpo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: "grpo__id"
            nombre column: "grponmbr"
            encargado column: "prsnencr"
            fechaCreacion column: "grpofccr"
            fechaFin column: "grpofcfn"
        }
    }

    static constraints = {
        nombre size: 5..30
        fechaFin nullable: true
    }
}
