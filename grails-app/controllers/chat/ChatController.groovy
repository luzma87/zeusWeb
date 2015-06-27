package chat

import groovy.json.JsonBuilder
import mensajes.Incidente
import seguridad.Persona
import seguridad.Shield

class ChatController extends Shield {

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
                unidades  : [
                        clase  : "btn-warning",
                        prefijo: "und",
                        title  : "Avanzan unidades",
                        icon   : "fa-motorcycle"
                ],
                sospechoso: [
                        clase  : "btn-danger",
                        prefijo: "ssd",
                        title  : "Sospechoso detenido",
                        icon   : "fa-child"
                ],
                falsa     : [
                        clase  : "btn-primary",
                        prefijo: "fls",
                        title  : "Falsa alarma",
                        icon   : "fa-times"
                ],
                novedad   : [
                        clase  : "btn-success",
                        prefijo: "snn",
                        title  : "Sin novedad",
                        icon   : "fa-check"
                ]
        ]

        def folder = "32px_bubble"
        messageHandlerService.sendMensaje("lgn:La Policía Nacional ha ingresado al chat")
        return [user: user, botones: botones, folder: folder]
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
