package chat

import groovy.json.JsonBuilder
import seguridad.Persona
import seguridad.Shield

class ChatPoliciaController extends Shield {
    static scope = "session"
    static proxy = true

    def messageHandlerServicePoliciaService

    def index() {
        def pers = Persona.get(session.usuario.id)
        def user = pers.login
        def pass = pers.password
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Policia"

        messageHandlerServicePoliciaService.inicio(user, pass, ip, serverName, roomName)

        def botones = []
//        def botones = [
//                unidades  : [
//                        clase  : "btn-warning",
//                        title  : "Avanzan unidades",
//                        icon   : "fa-motorcycle",
//                        prefijo: "und"
//                ],
//                sospechoso: [
//                        clase  : "btn-danger",
//                        title  : "Sospechoso detenido",
//                        icon   : "fa-child",
//                        prefijo: "ssd"
//                ],
//                falsa     : [
//                        clase  : "btn-primary",
//                        title  : "Falsa alarma",
//                        icon   : "fa-times",
//                        prefijo: "fls"
//                ],
//                novedad   : [
//                        clase  : "btn-success",
//                        title  : "Sin novedad",
//                        icon   : "fa-check",
//                        prefijo: "snn"
//                ],
//                comunidad : [:]
//        ]

        return [user: user, botones: botones, persona: pers]
    }

    def ventanaMapa() {
        def pers = Persona.get(session.usuario.id)
        def user = pers.login
        def pass = pers.password
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Policia"
        messageHandlerServicePoliciaService.inicio(user, pass, ip, serverName, roomName)

        return [user: user]
    }

    def getMessages_ajax() {
        def actual
        if (params.actual) {
            actual = params.actual.toInteger()
        } else {
            actual = 0
        }
        def mensajes = messageHandlerServicePoliciaService.getMensajes(actual)

        if (mensajes.size() > 0) {
            def json = new JsonBuilder(mensajes.reverse())
            // println json.toPrettyString()
            render json
            return
        }
        render "[]"
        return
        // println "mensajes"

    }

    def enviarMensaje_ajax() {
        messageHandlerServicePoliciaService.sendMensaje(params.mensaje)
        render "ok"
    }

    def getInfoMensaje_ajax() {
        println "params " + params
        def p = Persona.findByLogin(params.user)
        [personaInstance: p]
    }
}
