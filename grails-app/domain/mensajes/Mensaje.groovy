package mensajes

class Mensaje {

    Conversacion conversacion
    String fromJID
    String fromJIDResource
    String toJID
    String toJIDResource
    String body

    static mapping = {
        table 'ofMessageArchive'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'assigned'
        columns {
            id column: 'sentDate'
            conversacion column: 'conversationID'
            fromJID column: 'fromJID'
            fromJIDResource column: 'fromJIDResource'
            toJID column: 'toJID'
            toJIDResource column: 'toJIDResource'
            body column: 'body'
        }
    }

    static constraints = {
    }
}
