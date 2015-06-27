package chat

import groovy.json.JsonBuilder
import seguridad.Persona
import seguridad.Shield

class ChatPoliciaController extends Shield {

    def messageHandlerServicePoliciaService
    static scope = "session"

    def index() {
        def user = "test4"
        def pass = "123456"
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Policia"

        messageHandlerServicePoliciaService.inicio(user, pass, ip, serverName, roomName)

        def botones = [
                unidades  : [
                        clase  : "btn-warning",
                        title  : "Avanzan unidades",
                        icon   : "fa-motorcycle",
                        prefijo: "und"
                ],
                sospechoso: [
                        clase  : "btn-danger",
                        title  : "Sospechoso detenido",
                        icon   : "fa-child",
                        prefijo: "ssd"
                ],
                falsa     : [
                        clase  : "btn-primary",
                        title  : "Falsa alarma",
                        icon   : "fa-times",
                        prefijo: "fls"
                ],
                novedad   : [
                        clase  : "btn-success",
                        title  : "Sin novedad",
                        icon   : "fa-check",
                        prefijo: "snn"
                ],
                comunidad : [:]
        ]

        return [user: user, botones: botones]
    }

    def ventanaMapa() {
        def user = "test4"
        def pass = "123456"
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Policia"
        messageHandlerServicePoliciaService.inicio(user, pass, ip, serverName, roomName)

        return [user: user]
    }

    def getMessages() {
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

    def enviarMensaje() {
        messageHandlerServicePoliciaService.sendMensaje(params.mensaje)
        render "ok"
    }


    def getInfoMensaje() {
        println "params " + params
        def p = Persona.findByLogin(params.user)
        [personaInstance: p]
    }

    def prueba() {

        /*Chat chat2 = chatManager.createChat("test2" + "@" + "svt-pc");
        try {
            chat2.sendMessage("prueba");
        } catch (SmackException.NotConnectedException e) {
            e.printStackTrace();
        }
        */
        render "ok"
    }
}
