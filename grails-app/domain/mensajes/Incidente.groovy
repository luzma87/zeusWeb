package mensajes

class Incidente {

    String de
    String fecha
    String tipo
    double latitud
    double longitud

    String estado // P: pendiente, R: resuelto

    static mapping = {
        table 'incd'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'incd__id'
            de column: "incdfrom"
            fecha column: "incdfcha"
            tipo column: "incdtipo"
            latitud column: "incdlttd"
            longitud column: "incdlngt"
            estado column: "incdetdo"
        }
    }

    static constraints = {
        estado inList: ['P', 'R']
    }
}
