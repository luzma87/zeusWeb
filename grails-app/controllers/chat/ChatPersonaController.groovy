package chat

import groovy.json.JsonBuilder
import mensajes.Incidente
import seguridad.Persona
import seguridad.Shield

class ChatPersonaController extends Shield {
    static scope = "session"
    static proxy = true
    def messageHandlerService

//    AbstractXMPPConnection conn2 = null

    def getInfoMensajeChat_ajax() {
        println "params info " + params
        def inc = Incidente.get(params.id)
        def folder = "32px_bubble"
        def tipos = [
                loc: [
                        icono: resource(dir: 'images/pins/' + folder, file: 'location32.png'),
                        title: "Ubicación"
                ],
                asL: [
                        icono: resource(dir: 'images/pins/' + folder, file: 'thief1.png'),
                        title: "Asalto"
                ],
                acL: [
                        icono: resource(dir: 'images/pins/' + folder, file: 'cars1.png'),
                        title: "Accidente"
                ],
                ssL: [
                        icono: resource(dir: 'images/pins/' + folder, file: 'businessman205.png'),
                        title: "Sospechoso"
                ],
                inL: [
                        icono: resource(dir: 'images/pins/' + folder, file: 'bill7.png'),
                        title: "Intruso"
                ],
                lbL: [
                        icono: resource(dir: 'images/pins/' + folder, file: 'healthyfood1.png'),
                        title: "Libadores"
                ]
        ]

        return [params: params, tipos: tipos, inc: inc]
    }

    def cambiaEstado_ajax() {
        println "params cambia estado " + params
        def inc = Incidente.get(params.id)
        inc.estado = "R"
        if (!inc.save(flush: true)) {
            println "error " + inc.save()
        }
        render "ok"
    }

    def index() {
        def pers = Persona.get(session.usuario.id)
        def user = pers.login
        def pass = pers.password

        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Jipijapa"
        println "chat users"
        messageHandlerService.inicio(user, pass, ip, serverName, roomName)

        def botones = [
                asalto    : [
                        clase  : "btn-asalto",
                        prefijo: "asL",
                        title  : "Asalto, necesito ayuda!",
                        icon   : "flaticon-thief1"
                ],
                accidente : [
                        clase  : "btn-accidente",
                        prefijo: "acL",
                        title  : "Accidente",
                        icon   : "flaticon-cars1"
                ],
                sospechoso: [
                        clase  : "btn-sospechoso",
                        prefijo: "ssL",
                        title  : "Sospechoso",
                        icon   : "flaticon-businessman205"
                ],
                intruso   : [
                        clase  : "btn-intruso",
                        prefijo: "inL",
                        title  : "Intruso",
                        icon   : "flaticon-bill7"
                ],
                libadores : [
                        clase  : "btn-libadores",
                        prefijo: "lbL",
                        title  : "Libadores",
                        icon   : "flaticon-healthyfood1"
                ],
                ubicacion : [
                        clase  : "btn-ubicacion",
                        prefijo: "loc",
                        title  : "Mi ubicación",
                        icon   : "flaticon-location32"
                ]
        ]

        def folder = "32px_bubble"
        return [user: user, botones: botones, folder: folder, persona: pers]
    }

    def ventanaMapa() {
        def pers = Persona.get(session.usuario.id)
        def user = pers.login
        def pass = pers.password
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Policia"
        messageHandlerService.inicio(user, pass, ip, serverName, roomName)

        return [user: user]
    }

    def getMessages_ajax() {
        def actual
        if (params.actual) {
            actual = params.actual.toInteger()
        } else {
            actual = 0
        }
        def mensajes = messageHandlerService.getMensajes(actual)

        if (mensajes.size() > 0) {
            def json = new JsonBuilder(mensajes.reverse())
            // println json.toPrettyString()
            render json
            return
        }
        render "[]"
        // println "mensajes"
    }

    def getIncidentes_ajax() {
        def actual
        if (params.actual) {
            actual = params.actual.toInteger()
        } else {
            actual = 0
        }
        def mensajes = messageHandlerService.getIncidentes(actual)

        if (mensajes.size() > 0) {
            def json = new JsonBuilder(mensajes.reverse())
            // println json.toPrettyString()
            render json
            return
        }
        render "[]"
    }

    def enviarMensaje_ajax() {
        messageHandlerService.sendMensaje(params.mensaje)
        render "ok"
    }

    def getInfoMensaje_ajax() {
        println "params " + params
        def p = Persona.findByLogin(params.user)
        [personaInstance: p]
    }
}
