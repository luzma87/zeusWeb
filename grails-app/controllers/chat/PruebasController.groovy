package chat

import grails.web.JSONBuilder
import groovy.json.JsonBuilder
import org.codehaus.groovy.grails.web.json.JSONObject
import org.jivesoftware.smack.AbstractXMPPConnection
import org.jivesoftware.smack.ConnectionConfiguration
import org.jivesoftware.smack.SmackException
import org.jivesoftware.smack.chat.Chat
import org.jivesoftware.smack.chat.ChatManager
import org.jivesoftware.smack.chat.ChatManagerListener
import org.jivesoftware.smack.chat.ChatMessageListener
import org.jivesoftware.smack.packet.Message
import org.jivesoftware.smack.tcp.XMPPTCPConnection
import org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration
import seguridad.Persona
import seguridad.Shield


class PruebasController extends Shield {

    def messageHandlerService
    static scope = "session"

    def index() {

        XMPPTCPConnectionConfiguration config = XMPPTCPConnectionConfiguration.builder()
                .setUsernameAndPassword("valentinsvt", "123456")
                .setServiceName("vps44751.vps.ovh.ca")
                .setHost("167.114.144.175")
                .setPort(5222)
                .setSecurityMode(ConnectionConfiguration.SecurityMode.disabled)
                .build();

        AbstractXMPPConnection conn2 = new XMPPTCPConnection(config);
        conn2.connect();
        conn2.login();
        System.out.println("name = " + conn2.getUser())
        messageHandlerService.inicio(conn2)
        [user: "valentinsvt"]
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
        return
        // println "mensajes"

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
