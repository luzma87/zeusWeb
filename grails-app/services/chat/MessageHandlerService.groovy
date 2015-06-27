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
    def listener

    def tipos = [
            "loc":"Ubicación",
            "asL":"Asalto",
            "acL":"Accidente",
            "ssL":"Sospechoso",
            "inL":"Intruso",
            "lbL":"Libadores"
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

                println "Conectado como " + user
            } catch (e) {
//                println "CATCH"
                e.printStackTrace()
            }
        }

        def mucm = MultiUserChatManager.getInstanceFor(con)
        muc = mucm.getMultiUserChat("${roomName}@conference.${serverName}")
        muc.leave()
        muc.removeMessageListener(listener)
        if(!listener){
            listener = new MessageListener() {
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

                    if (inf != null) {
                        dDate = inf.getStamp()
                    } else {
                        dDate = new Date()
                    }
                    def tmp = [:]
                    def msg = message.getBody()
                    def de = message.getFrom().split("/")[1]
                    def tipo = msg[0..2]
                    def iden = 0
                    println "msg " + msg
                    println "tipo " + tipo
                    if (tipos[tipo]) {
                        def parts = msg.split(":")
                        def coords = parts.last()
                        parts = coords.split(",")
                        def incId = creaIncidente(de, dDate, tipos[tipo], parts)
                        if (incId>0) {
                            iden=incId
                        }
                    }
                    date = dDate.format("dd-MM-yyyy HH:mm:ss")

                    tmp.put("mensaje", msg)
                    tmp.put("tipo", 1)
                    tmp.put("de", de)
                    tmp.put("type", message.getType())
                    tmp.put("hora", date)
                    tmp.put("id", iden)

                    addMensaje(tmp)


                    indice++
                }
            }
        }
        try {
            if (!muc.isJoined()) {
                indice = 0
                indiceInc = 0
                mensajes = []
                incidentes = []
                muc.join(user, pass)
                muc.addMessageListener(listener);
            }else{
                println "si es joined no hizo nada"
            }
        } catch (e) {
//            println "eerror " + e
        }
    }

    def creaIncidente(de, dDate, tipo, coords) {
        def check = Incidente.findAll("from Incidente  where tipo='${tipo}' and longitud=${coords[1]} and latitud=${coords[0]}")
        println "check "+check
        if(check.size()>0)
            return check.pop().id
        else {
            def inc = new Incidente()
            inc.de = de
            inc.fecha = dDate
            inc.tipo = tipo
            inc.latitud = coords[0].toDouble()
            inc.longitud = coords[1].toDouble()
            inc.estado = "P"

            if (!inc.save(flush: true)) {
                println "Error al guardar incidente: " + inc.errors
                return 0
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


    def sendMensaje(String mensaje) {
//        println "send mensaje"
        Message msn = new Message()
        msn.setType(Message.Type.groupchat)
        msn.setBody(mensaje)
        msn.setTo("Jipijapa")
        muc.sendMessage(msn)
    }
}
