package mapas

import mensajes.Conversacion
import mensajes.Mensaje
import mensajes.Room

class MapaController {

    def index() {

//        def rooms = Room.list()
//        def conversaciones = Conversacion.list()
//        def mensajes = Mensaje.list()

        def room = Room.findByName("jipijapa")
        def conversaciones = Conversacion.findAllByRoomIlike("%" + room.name + "%")
//        def mensajes = Mensaje.findAllByConversacionInList(conversacion

        def tiposIncidencia = [
                loc: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'location32.png'),
                        title   : "Ubicaci�n"
                ],
                asL: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'thief1.png'),
                        title   : "Asalto"
                ],
                acL: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'cars1.png'),
                        title   : "Accidente"
                ],
                ssL: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'businessman205.png'),
                        title   : "Sospechoso"
                ],
                inL: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'bill7.png'),
                        title   : "Intruso"
                ],
                lbL: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'healthyfood1.png'),
                        title   : "Libadores"
                ]/*,
                loL: [
                        mensajes: [],
                        icono   : resource(dir: 'images/pins', file: 'location32.png'),
                        title   : "Ubicaci�n"
                ]*/
        ]

        tiposIncidencia.each { key, v ->
            def mensajes = Mensaje.withCriteria {
                inList("conversacion", conversaciones)
                ilike("body", key + "%")
            }
            v.mensajes = mensajes
        }

//        println "ROOMS: " + room
//        println "CONVS: " + conversaciones
//        println "MENJS: " + tiposIncidencia

        return [tiposIncidencia: tiposIncidencia]
    }


}