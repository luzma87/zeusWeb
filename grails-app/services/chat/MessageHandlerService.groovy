package chat


import org.jivesoftware.smack.AbstractXMPPConnection
import org.jivesoftware.smack.ConnectionConfiguration
import org.jivesoftware.smack.MessageListener
import org.jivesoftware.smack.SmackException
import org.jivesoftware.smack.chat.Chat
import org.jivesoftware.smack.chat.ChatManager
import org.jivesoftware.smack.chat.ChatManagerListener
import org.jivesoftware.smack.chat.ChatMessageListener
import org.jivesoftware.smack.packet.Message
import org.jivesoftware.smack.tcp.XMPPTCPConnection
import org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration
import org.jivesoftware.smackx.delay.packet.DelayInformation
import org.jivesoftware.smackx.muc.MultiUserChatManager

class MessageHandlerService {

    def mensajes = []
    def con
    int indice=0
    def muc
    def inicio(conn2) {

        this.con=conn2
        def mucm = MultiUserChatManager.getInstanceFor(conn2)
        indice=0
        mensajes=[]
        muc = mucm.getMultiUserChat("Jipijapa@conference.vps44751.vps.ovh.ca")
        try{
            if(!muc.isJoined()){
                muc.join("valentinsvt")
                muc.addMessageListener(new MessageListener() {
                    @Override
                    void processMessage(Message message) {
                        DelayInformation inf = null;
                        def date
                       // println "xml "+message.toXML()
                        //println "xml2 "+message.getExtensionsXML()
                        //println "xml3 "+message.getExtension("urn:xmpp:delay").toXML()
                        try {
                            inf = (DelayInformation)message.getExtension("urn:xmpp:delay");
                        } catch (Exception e) {
                            log.error(e);
                        }
// get offline message timestamp
                        if(inf!=null) {
                            date = inf.getStamp().format("dd-MM-yy HH:mm:ss");
                            //println "stored "+date
                        }else
                            date = new Date().format("dd-MM-yy HH:mm:ss")
                        def tmp = [:]
                        tmp.put("mensaje",message.getBody())
                        tmp.put("tipo",1)
                        tmp.put("de",message.getFrom().split("/")[1])
                        tmp.put("type",message.getType())
                        tmp.put("hora",date)

                        addMensaje(tmp)
                        indice++
                    }
                } );
            }
        }catch (e){
            println "eerror "+e
        }

    }

    def addMensaje(mensaje){
        mensajes.add(0,mensaje)
        if(mensajes.size()>100)
            mensajes.pop()
    }

    def getMensajes(actual){

        if(mensajes.size()>0) {
            def i=indice-actual
            if(i>0) {
                if(i>100)
                    return mensajes
                else
                    return mensajes[0..i - 1]
            }else
                return []
        }else{
            return []
        }
    }
    def sendMensaje(String mensaje){
        Message msn = new Message()
        msn.setType(Message.Type.groupchat)
        msn.setBody(mensaje)
        msn.setTo("Jipijapa")
        muc.sendMessage(msn)
    }
}
