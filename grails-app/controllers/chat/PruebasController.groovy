package chat

import org.jivesoftware.smack.AbstractXMPPConnection
import org.jivesoftware.smack.tcp.XMPPTCPConnection
import org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration


class PruebasController {

    def index() {}

    def prueba(){

        XMPPTCPConnectionConfiguration config = XMPPTCPConnectionConfiguration.builder()
                .setUsernameAndPassword("test1", "123")
                .setServiceName("svt-pc")
                .setHost("192.168.1.132")
                .setPort(5223)
                .build();

        AbstractXMPPConnection conn2 = new XMPPTCPConnection(config);
        conn2.connect();


        render "ok"
    }
}
