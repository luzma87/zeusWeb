package mensajes

class Conversacion {


    String room
    Double startDate
    Double lastActivity
    int messageCount

    static mapping = {
        table 'ofConversation'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'conversationId'
            room column: 'room'
            startDate column: 'startDate'
            lastActivity column: 'lastActivity'
            messageCount column: 'messageCount'
        }
    }

    static constraints = {
    }
}
