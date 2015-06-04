package parametros

class TipoEvento {
    String nombre
    Integer orden = 1
    String color = ""
    String icono = ""

    static mapping = {
        table 'tpev'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort orden: "desc"
        columns {
            id column: "tpev__id"
            nombre column: "tpevnmbr"
            orden column: "tpevordn"
            color column: "tpevclor"
            icono column: "tpevicno"
        }
    }

    static constraints = {
    }
}
