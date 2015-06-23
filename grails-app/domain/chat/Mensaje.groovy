package chat

class Mensaje {

    PersonaGrupo personaGrupo
    String tipo
    String mensaje
    Date fechaCreacion
    Date fechaEnvio
    Date fechaRecepcion
    Date fechaLectura

    static mapping = {
        table 'mnsj'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fechaEnvio: "desc"
        columns {
            id column: "mnsj__id"
            tipo column: 'mnsjtipo'
            personaGrupo column: "prgr__id"
            mensaje column: "mnsjmnsj"
            fechaCreacion column: "mnsjfccr"
            fechaRecepcion column: "mnsjfcrc"
            fechaLectura column: "mnsjfclc"
        }
    }

    static constraints = {
        fechaEnvio nullable: true
        fechaRecepcion nullable: true
        fechaLectura nullable: true
    }
}
