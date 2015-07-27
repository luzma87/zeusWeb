package documentos

import seguridad.Persona

class DocumentoPersona {

    Persona persona
    Documento documento
    Date fechaPresentacion = new Date()

    static mapping = {
        table 'dcpr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dcpr__id'
            persona column: 'prsn__id'
            documento column: 'dcmt__id'
            fechaPresentacion column: 'dcprfcpr'
        }
    }

    static constraints = {
    }
}
