package mensajes

class Room {

    Double creationDate
    Double modificationDate
    String name
    String naturalName
    String description
    String roomPassword
    String subject


    static mapping = {
        table 'ofMucRoom'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'roomId'
            creationDate column: 'creationDate'
            modificationDate column: 'modificationDate'
            name column: 'name'
            naturalName column: 'naturalName'
            description column: 'description'
            roomPassword column: 'roomPassword'
            subject column: 'subject'
        }
    }

    static constraints = {
        roomPassword nullable: true
    }
}
