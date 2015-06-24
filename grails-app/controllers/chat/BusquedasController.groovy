package chat

import mensajes.Mensaje

class BusquedasController {

    def index() {

    }

    def buscar(){
        println "params "+params
        def desde = new Date().parse("dd-MM-yyyy HH:mm",params.desde)
        def hasta
        if(params.hasta!=""){
            hasta = new Date().parse("dd-MM-yyyy HH:mm",params.hasta)
        }else{
            hasta = new Date()
        }
        def lista = Mensaje.withCriteria {
            gt("id",desde.getTime())
            lt("id",hasta.getTime())
            if(params.de && params.de!=""){
                ilike("fromJID",params.de+"%")
            }
            if(params.para && params.para!=""){
                ilike("toJID",params.para+"%")
            }
        }
        [lista:lista]
    }
}
