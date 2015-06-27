package chat

import mensajes.Mensaje
import seguridad.Shield

class BusquedasController extends Shield {

    def index() {

    }

    def buscar_ajax() {
        println "params " + params
        def desde = new Date().parse("dd-MM-yyyy HH:mm", params.desde)
        def hasta
        if (params.hasta != "") {
            hasta = new Date().parse("dd-MM-yyyy HH:mm", params.hasta)
        } else {
            hasta = new Date()
        }
        def lista = Mensaje.withCriteria {
            gt("id", desde.getTime())
            lt("id", hasta.getTime())
            if (params.de && params.de != "") {
                ilike("fromJID", params.de + "%")
            }
            if (params.para && params.para != "") {
                ilike("toJID", params.para + "%")
            }
        }
        [lista: lista]
    }
}
