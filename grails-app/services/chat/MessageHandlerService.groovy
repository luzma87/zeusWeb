package chat

import grails.transaction.Transactional
import mensajes.Incidente
import org.jivesoftware.smack.AbstractXMPPConnection
import org.jivesoftware.smack.ConnectionConfiguration
import org.jivesoftware.smack.MessageListener
import org.jivesoftware.smack.packet.Message
import org.jivesoftware.smack.tcp.XMPPTCPConnection
import org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration
import org.jivesoftware.smackx.delay.packet.DelayInformation
import org.jivesoftware.smackx.muc.MultiUserChatManager

@Transactional
class MessageHandlerService {

    static transactional = true

    def mensajes = []
    def incidentes = []

    AbstractXMPPConnection con
    int indice = 0
    int indiceInc = 0
    def muc

    def tipos = [
            "loc",
            "asL",
            "acL",
            "ssL",
            "inL",
            "lbL"
    ]

    def inicio(String user, String pass, String serverIp, String serverName, String roomName) {

//        println "Servicio: inicio"

        if (!con || !con.connected || !con.authenticated) {
            try {
                XMPPTCPConnectionConfiguration config = XMPPTCPConnectionConfiguration.builder()
                        .setUsernameAndPassword(user, pass)
                        .setServiceName(serverName)
                        .setHost(serverIp)
                        .setPort(5222)
                        .setSecurityMode(ConnectionConfiguration.SecurityMode.disabled)
                        .build();

                con = new XMPPTCPConnection(config);
                con.connect();
                con.login();
            } catch (e) {
//                println "CATCH"
                e.printStackTrace()
            }
        }

        def mucm = MultiUserChatManager.getInstanceFor(con)
        muc = mucm.getMultiUserChat("${roomName}@conference.${serverName}")
        try {
            if (!muc.isJoined()) {
                indice = 0
                indiceInc = 0
                mensajes = []
                incidentes = []
                muc.join(user, pass)
                muc.addMessageListener(new MessageListener() {
                    @Override
                    void processMessage(Message message) {
                        DelayInformation inf = null;
                        def date
                        def dDate
//                        println "AQUI"
////                        println "xml " + message.toXML()
////                        println "xml2 " + message.getExtensionsXML()
////                        println "xml3 " + message.getExtension("urn:xmpp:delay").toXML()
                        try {
                            inf = (DelayInformation) message.getExtension("urn:xmpp:delay");
                        } catch (Exception e) {
                            log.error(e);
                        }
// get offline message timestamp
                        if (inf != null) {
                            dDate = inf.getStamp()
//                            date = inf.getStamp().format("dd-MM-yy HH:mm:ss");
                            ////println "stored "+date
                        } else {
                            dDate = new Date()
//                            date = new Date().format("dd-MM-yy HH:mm:ss")
                        }
                        date = dDate.format("dd-MM-yyyy HH:mm:ss")
                        def tmp = [:]
                        def msg = message.getBody()
                        def de = message.getFrom().split("/")[1]
                        tmp.put("mensaje", msg)
                        tmp.put("tipo", 1)
                        tmp.put("de", de)
                        tmp.put("type", message.getType())
                        tmp.put("hora", date)

                        addMensaje(tmp)

                        def tipo = msg[0..2]
                        println "msg " + msg
                        println "tipo " + tipo
                        if (tipos.contains(tipo)) {
                            def parts = msg.split(":")
                            def coords = parts.last()
                            parts = coords.split(",")

                            def incId = creaIncidente(de, dDate, tipo, parts)
                            if (incId) {
                                tmp.put("id", incId)
                            }
                        }

                        indice++
                    }
                });
            }
        } catch (e) {
//            println "eerror " + e
        }
    }

    def creaIncidente(de, dDate, tipo, coords) {
        def inc = new Incidente()
        inc.de = de
        inc.fecha = dDate
        inc.tipo = tipo
        inc.latitud = coords[0].toDouble()
        inc.longitud = coords[1].toDouble()
        inc.estado = "P"
        if (!inc.save(flush: true)) {
            println "Error al guardar incidente: " + inc.errors
            return null
        } else {
            println "incidente guardado"
            incidentes.add(0, inc)
            if (incidentes.size() > 100) {
                incidentes.pop()
            }
            indiceInc++
            return inc.id
        }
    }

    def addMensaje(mensaje) {
//        println "add mensaje"
        mensajes.add(0, mensaje)
        if (mensajes.size() > 100) {
            mensajes.pop()
        }
    }

    def getMensajes(actual) {
//        println "get mensaje"
        if (mensajes.size() > 0) {
            def i = indice - actual
            if (i > 0) {
                if (i > 100) {
                    return mensajes
                } else {
                    return mensajes[0..i - 1]
                }
            } else {
                return []
            }
        } else {
            return []
        }
    }

    def getIncidentes(actual) {
        println "incidentes: " + incidentes
        if (incidentes.size() > 0) {
            def i = indiceInc - actual
            if (i > 0) {
                if (i > 100) {
                    println "1"
                    return incidentes
                } else {
                    println "2"
                    return incidentes[0..i - 1]
                }
            } else {
                println "3"
                return []
            }
        } else {
            println "4"
            return []
        }
    }

    def sendMensaje(String mensaje) {
//        println "send mensaje"
        Message msn = new Message()
        msn.setType(Message.Type.groupchat)
        msn.setBody(mensaje)
        msn.setTo("Jipijapa")
        muc.sendMessage(msn)
    }
}
