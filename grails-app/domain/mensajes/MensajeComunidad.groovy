package mensajes

class MensajeComunidad {

    String resumen
    String contenido

    static mapping = {
        table 'mscm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mscm__id'
            resumen column: 'mscmrsmn'
            contenido column: 'mscmcntn'
            contenido type: "text"
        }
    }

    static constraints = {
        resumen maxSize: 30
    }
}
