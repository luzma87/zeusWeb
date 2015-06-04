package chat

class RespuestaRapida {

    String respuesta
    Integer orden = 0

    static mapping = {
        table 'rsrp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort orden: "desc"
        columns {
            id column: "prgr__id"
            respuesta column: "rsrprspt"
            orden column: "rsrpordn"
        }
    }

    static constraints = {
    }
}
