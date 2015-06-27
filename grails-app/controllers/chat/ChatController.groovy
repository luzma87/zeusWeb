package chat

import groovy.json.JsonBuilder
import seguridad.Persona

class ChatController {

    def messageHandlerService
    static scope = "session"

//    AbstractXMPPConnection conn2 = null

    def getInfoMensajeChat_ajax() {

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

        return [params: params, tipos: tipos]
    }

    def index() {
//        println "conn2.connected? " + conn2.connected
//        println "conn2.authenticated? " + conn2.authenticated
//        if (!conn2.authenticated) {
//            try {
//                XMPPTCPConnectionConfiguration config = XMPPTCPConnectionConfiguration.builder()
//                        .setUsernameAndPassword("valentinsvt", "123456")
//                        .setServiceName("vps44751.vps.ovh.ca")
//                        .setHost("167.114.144.175")
//                        .setPort(5222)
//                        .setSecurityMode(ConnectionConfiguration.SecurityMode.disabled)
//                        .build();
//
//                conn2 = new XMPPTCPConnection(config);
//                conn2.connect();
//                conn2.login();
//            } catch (e) {
//                println "CATCH"
//                e.printStackTrace()
//            }
//        }
//        System.out.println("name = " + conn2.getUser())
        def user = "test3"
        def pass = "123"
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Jipijapa"

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
                ],
                comunidad : [:]
        ]

        def folder = "32px_bubble"

        return [user: user, botones: botones, folder: folder]
    }

    def ventanaMapa() {
        def user = "test4"
        def pass = "123456"
        def ip = "167.114.144.175"
        def serverName = "vps44751.vps.ovh.ca"
        def roomName = "Policia"
        messageHandlerService.inicio(user, pass, ip, serverName, roomName)

        return [user: user]
    }

    def getMessages() {
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

    def getIncidentes () {
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

    def enviarMensaje() {
        messageHandlerService.sendMensaje(params.mensaje)
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
