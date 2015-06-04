package chat

import seguridad.Persona

class PersonaGrupo {

    Persona persona
    Grupo grupo
    Date fechaInicio
    Date fechaFin

    static mapping = {
        table 'prgr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort grupo: "asc"
        columns {
            id column: "prgr__id"
            persona column: "prsn__id"
            grupo column: "grpo__id"
            fechaInicio column: "prgrfcin"
            fechaFin column: "prgrfcfn"
        }
    }

    static constraints = {
        fechaFin nullable: true
    }
}
