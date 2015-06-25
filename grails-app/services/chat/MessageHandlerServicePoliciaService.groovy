package chat

import grails.transaction.Transactional
import org.jivesoftware.smack.AbstractXMPPConnection
import org.jivesoftware.smack.ConnectionConfiguration
import org.jivesoftware.smack.MessageListener
import org.jivesoftware.smack.packet.Message
import org.jivesoftware.smack.tcp.XMPPTCPConnection
import org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration
import org.jivesoftware.smackx.delay.packet.DelayInformation
import org.jivesoftware.smackx.muc.MultiUserChatManager

@Transactional
class MessageHandlerServicePoliciaService {
    def mensajes = []
    AbstractXMPPConnection con
    int indice = 0
    def muc

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
                mensajes = []
                muc.join(user, pass)
                muc.addMessageListener(new MessageListener() {
                    @Override
                    void processMessage(Message message) {
                        DelayInformation inf = null;
                        def date
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
                            date = inf.getStamp().format("dd-MM-yy HH:mm:ss");
                            ////println "stored "+date
                        } else {
                            date = new Date().format("dd-MM-yy HH:mm:ss")
                        }
                        def tmp = [:]
                        tmp.put("mensaje", message.getBody())
                        tmp.put("tipo", 1)
                        tmp.put("de", message.getFrom().split("/")[1])
                        tmp.put("type", message.getType())
                        tmp.put("hora", date)

                        addMensaje(tmp)
                        indice++
                    }
                });
            }
        } catch (e) {
//            println "eerror " + e
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
        msn.setTo("Policia")
        muc.sendMessage(msn)
    }
}
